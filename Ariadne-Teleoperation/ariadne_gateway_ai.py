import os
import json
import time
import socket
import re
from typing import Optional, Tuple, Dict

from openai import OpenAI

# ============================================================
# CONFIG
# ============================================================
HOST = "127.0.0.1"
PORT = 12345

# These must match KAREL program safety envelope
# (Z clamp + cylindrical XY clamp around WORLD origin 0,0)
R_MAX = 1450.0      # demo cylinder radius (WORLD XY)
Z_LOW = -350.0      # demo Z min
Z_HIGH = 965.0      # demo Z max

# Pick a model
OPENAI_MODEL = "gpt-4.1-mini"

# Define model behavior
AI_TEMPERATURE = 0.7


# ============================================================
# SYSTEM PROMPT
# ============================================================
SYSTEM_PROMPT = """
You are an industrial robot teleoperation command interpreter.

Context:
- The robot is controlled using WORLD-frame translation deltas only.
- Units: millimeters (mm).
- Output only dx, dy, dz (translation). Ignore rotations.
- Operator stands in front of the robot.

AXIS MAPPING (IMPORTANT):
- Forward  => +dx
- Backward => -dx
- Right    => +dy
- Left     => -dy
- Up       => +dz
- Down     => -dz

You will be given:
1) CURRENT pose (WORLD): X, Y, Z
2) SAFETY limits:
   - r_max: maximum allowed XY radius around WORLD origin (0,0) (cylindrical limit)
   - z_low, z_high: allowed Z range

Task:
Convert the user's natural-language command into a JSON object with exactly these keys: dx, dy, dz.

Human-like magnitude policy:
- If the user provides a number, use it as millimeters (mm), but still respect the safety limits.
- If no number is provided, infer a natural human-like step size.

"Max" interpretation with a SMALL margin:
- For phrases like "max", "all the way", "as far as possible":
  choose a large step toward the requested direction BUT keep a small margin from limits:
  • keep at least ~50 mm margin inside the XY radius (r_max)
  • keep at least ~20 mm margin inside the Z range (z_low..z_high)
  If already close to a limit, reduce the step accordingly.

"Small" interpretation:
- For phrases like "a bit", "slightly", "a little":
  choose a small step, and make it smaller when close to a limit.

Safety behavior:
- If direction is unclear or ambiguous, return zeros.

Output format:
Return ONLY valid JSON. No extra text, no explanations, no code fences.
Always include all keys dx, dy, dz.

IMPORTANT:
- You MUST output deltas (dx,dy,dz), not an absolute target position.
- The safety limits apply to the resulting target position: TARGET = CURRENT + DELTA.
- Choose DELTA so that TARGET stays inside limits with a small margin.

Example output:
{"dx": 0, "dy": 0, "dz": 0}
"""


# ============================================================
# SOCKET HELPERS
# ============================================================
def connect_with_retry(host: str, port: int, retries: int = 400, delay: float = 0.05) -> socket.socket:
    """Connect when robot KAREL is blocking on MSG_CONNECT."""
    last_err = None
    for _ in range(retries):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect((host, port))
            return s
        except OSError as e:
            last_err = e
            time.sleep(delay)
    raise RuntimeError(f"Cannot connect to {host}:{port}. Last error: {last_err}")


def recv_all(sock: socket.socket, timeout: float = 1.5) -> bytes:
    """Receive all data until peer closes or timeout."""
    sock.settimeout(timeout)
    chunks = []
    while True:
        try:
            data = sock.recv(4096)
            if not data:
                break
            chunks.append(data)
        except socket.timeout:
            break
    return b"".join(chunks)


def parse_first_6_numbers(text: str) -> Optional[Tuple[float, float, float, float, float, float]]:
    """
    Extract first 6 numbers from robot output (X,Y,Z,W,P,R)

    """
    nums = re.findall(r'[-+]?\d+(?:\.\d+)?', text)
    if len(nums) < 6:
        return None
    vals = list(map(float, nums[:6]))
    return tuple(vals)


def send_delta_xyz(dx: float, dy: float, dz: float) -> None:
    """Send delta as 'dx;dy;dz;0;0;0;'."""
    msg = f"{dx};{dy};{dz};0.0;0.0;0.0;"
    s = connect_with_retry(HOST, PORT)  # robot will be waiting in PY_TO_ROBOT
    s.sendall(msg.encode("utf-8"))
    s.close()
    print("Sent DELTA:", msg)


# ============================================================
# AI HELPERS
# ============================================================
def extract_json(text: str) -> Optional[Dict]:
    """Extract JSON object from model output (robust)."""
    text = text.strip()
    if text.startswith("{") and text.endswith("}"):
        try:
            return json.loads(text)
        except json.JSONDecodeError:
            return None

    m = re.search(r"\{.*\}", text, flags=re.DOTALL)
    if not m:
        return None
    try:
        return json.loads(m.group(0))
    except json.JSONDecodeError:
        return None


def ai_to_delta(client: OpenAI, user_command: str, x: float, y: float, z: float) -> Tuple[float, float, float]:
    """
    Ask AI for dx/dy/dz using command + current pose + limits.
    """
    context = (
        f"CURRENT: X={x:.1f}, Y={y:.1f}, Z={z:.1f} | "
        f"LIMITS: r_max={R_MAX:.1f}, z_low={Z_LOW:.1f}, z_high={Z_HIGH:.1f}\n"
        f"COMMAND: {user_command}"
    )

    resp = client.chat.completions.create(
        model=OPENAI_MODEL,
        messages=[
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": context},
        ],
        temperature=AI_TEMPERATURE,
    )

    content = resp.choices[0].message.content or ""
    data = extract_json(content)

    if not isinstance(data, dict):
        return 0.0, 0.0, 0.0

    try:
        dx = float(data.get("dx", 0.0))
        dy = float(data.get("dy", 0.0))
        dz = float(data.get("dz", 0.0))
    except (TypeError, ValueError):
        return 0.0, 0.0, 0.0

    return dx, dy, dz


# ============================================================
# MAIN
# ============================================================

def main():
    api_key = ''  # OpenAI API key here when needed

    if not api_key:
        raise RuntimeError(
            "Missing OpenAI API key. Paste it into the script before running."
        )

    client = OpenAI(api_key=api_key)


    print("=== ARIADNE Gateway AI ===")
    print("Axis mapping (operator in front of robot):")
    print("  forward=+X, back=-X, right=+Y, left=-Y, up=+Z, down=-Z")
    print(f"Demo limits: r_max={R_MAX}, Z=[{Z_LOW}..{Z_HIGH}]")
    print("Type natural-language commands. Type 'q' to quit.\n")

    while True:
        # 1) Receive current pose
        s = connect_with_retry(HOST, PORT)
        raw = recv_all(s)
        s.close()

        text = raw.decode("utf-8", errors="replace").strip()
        pos = parse_first_6_numbers(text)

        print("\n--- ROBOT -> PY (raw) ---")
        print(text)

        if not pos:
            print("WARN: Could not parse CURPOS. Sending zero delta to avoid hanging TP.")
            send_delta_xyz(0.0, 0.0, 0.0)
            continue

        x, y, z, w, p, r = pos
        print(f"Parsed CURPOS: X={x:.3f} Y={y:.3f} Z={z:.3f}  W={w:.3f} P={p:.3f} R={r:.3f}")

        # 2) User command
        cmd = input("CMD> ").strip()
        if cmd.lower() in ("q", "quit", "exit"):
            break

        # 3) AI -> delta using context (CURPOS + limits)
        try:
            dx, dy, dz = ai_to_delta(client, cmd, x, y, z)
            print(f"AI delta: dx={dx:.3f}, dy={dy:.3f}, dz={dz:.3f}")
        except Exception as e:
            print(f"AI ERROR: {e}. Sending zero delta.")
            dx = dy = dz = 0.0

        # 4) Send delta
        send_delta_xyz(dx, dy, dz)

    print("Bye.")


if __name__ == "__main__":
    main()