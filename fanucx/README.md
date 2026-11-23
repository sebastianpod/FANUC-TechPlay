# FanucX

FanucX is a Python library for building applications that communicate with and control FANUC robot controllers.

It allows application logic to be developed in Python while using ready-made controller components for communication, controller data access, position feedback, reachability checks, and robot Motion. Users do not need to create their own KAREL or TP programs for the operations already supported by FanucX.

> **Project status:** FanucX is currently available as an initial public release. Python packaging and simplified installation are planned for a future update.

---

## Features

FanucX provides a single Python API for working with key FANUC controller functions.

### Controller data

- Numeric Registers
- String Registers
- Position Registers
- KAREL program variables
- controller system variables
- alarm history and diagnostic information

### I/O

- Flags
- Digital Inputs and Outputs
- Group Inputs and Outputs
- Analog Inputs and Outputs
- Robot Inputs and Outputs
- UOP Inputs and Outputs
- SOP Inputs and Outputs

### Motion configuration

- User Frames
- Tool Frames
- Payload Schedules
- active frame and payload selection
- frame and payload comments

### Robot position and Motion

- current Cartesian position
- current Joint position
- Cartesian reachability checks
- Joint Motion
- Linear Motion
- FINE and CNT termination
- Motion result reporting
- Motion abort

---

## Architecture

FanucX consists of three cooperating parts:

```text
Python application
       |
       v
FanucX Python API
       |
       | TCP Socket Messaging
       v
FX_SERVER KAREL program
       |
       v
FANUC controller data and FXMOTION TP program
```

- The Python package provides the public application API
- `FX_SERVER` receives and validates protocol requests on the controller
- `FXMOTION` executes Joint and Linear Motion requests
- The communication protocol uses textual request-response messages over TCP

---

## Repository structure

```text
fanucx/
├── __init__.py
├── robot.py
├── motion.py
├── positions.py
├── ...
└── karel/
    ├── fx_server.kl
    ├── FXMOTION.LS
    └── includes/
        ├── fx_errors.kl
        ├── fx_protocol.kl
        ├── fx_string_utils.kl
        └── ...

docs/
├── alarms.md
├── connection.md
├── exceptions.md
├── io.md
├── motion-configuration.md
├── motion.md
├── positions.md
├── registers.md
├── variables.md
├── assets/
└── controller/
    ├── installation.md
    ├── protocol.md
    └── reserved-resources.md
```

---

## Requirements

### Python client

- Python 3
- network access to the FANUC controller or RoboGuide virtual controller

Formal Python package installation is not configured in the initial public release. Run examples and test scripts from the repository root so that Python can import the local `fanucx` package.

### FANUC controller

The tested controller configuration uses:

| Option code | Option name | Purpose |
|---|---|---|
| `R632` | KAREL | Runs the `FX_SERVER` controller program |
| `R648` | User Socket Messaging | Provides the TCP server connection |
| `R507` | ASCII Program Loader | Builds and loads `FXMOTION.LS` |

The initial release was developed and tested in FANUC RoboGuide with:

- RoboGuide `V9 Rev ZP`
- `ARC Mate 120iD` robot model
- `R-30iB Plus` virtual controller
- virtual controller software `V9.40P/63`

Controller behavior and option availability can differ between controller generations and software versions.

---

## Controller installation

The controller components must be configured and built before the Python client can connect.

The installation includes:

1. configuring a Socket Messaging server slot
2. setting the TCP server port
3. adding the KAREL and TP source files in RoboGuide
4. configuring the KAREL include path
5. building `FXMOTION.LS`
6. building `fx_server.kl`
7. verifying the reserved controller resources
8. starting `FX_SERVER`

See the illustrated [Controller Installation Guide](docs/controller/installation.md) for the complete procedure.

---

## Running from the repository

Until Python package installation is added, place a test script in the repository root:

```text
repository-root/
├── fanucx/
│   ├── __init__.py
│   └── ...
└── test_connection.py
```

Run it with:

```bash
python test_connection.py
```

---

## Quick start

The following example connects to a RoboGuide virtual controller running on the same computer:

```python
from fanucx import Robot


robot = Robot(
    host="127.0.0.1",
    port=12345,
    timeout=5,
)

robot.connect()

try:
    print(robot.cartesian())
    print(robot.joints())
finally:
    robot.disconnect()
```

The address and port must match the configured controller environment. For a physical controller, use the address assigned in the applicable network configuration.

---

## Basic examples

### Numeric Register

```python
value = robot.r[1]
robot.r[1] = 25
```

### Digital Output

```python
state = robot.do[1]
robot.do[1] = True
```

### Controller variable

```python
value = robot.variables.integer["*SYSTEM*", "$MOR_GRP[1].$CURRENT_ANG[1]"]
```

Refer to the variable documentation for the exact public access syntax supported by the current implementation.

### Current position

```python
cartesian = robot.cartesian()
joints = robot.joints()
```

### Reachability check

```python
reachable = robot.is_reachable(
    target,
    group=1,
    uframe=0,
    utool=1,
)
```

### Joint Motion

```python
from fanucx import JointPosition


target = JointPosition(
    (-90.0, 45.0, 0.0, 0.0, -90.0, 0.0)
)

result = robot.movej(
    target,
    speed=25,
    termination="FINE",
    group=1,
    uframe=0,
    utool=1,
)
```

### Linear Motion

```python
target = robot.cartesian()
target.z += 50.0

result = robot.movel(
    target,
    speed=100,
    termination="FINE",
    group=1,
    uframe=robot.uframe.active,
    utool=robot.utool.active,
)
```

Motion commands can move the robot immediately. Test new targets and applications in RoboGuide before using a physical controller.

---

## Documentation

### Python API

- [Connection](docs/connection.md)
- [Exceptions](docs/exceptions.md)
- [Position Types](docs/positions.md)
- [Registers](docs/registers.md)
- [I/O](docs/io.md)
- [Variables](docs/variables.md)
- [Alarms](docs/alarms.md)
- [Motion Configuration](docs/motion-configuration.md)
- [Motion](docs/motion.md)

### Controller

- [Controller Installation](docs/controller/installation.md)
- [FanucX Protocol](docs/controller/protocol.md)
- [Reserved Controller Resources](docs/controller/reserved-resources.md)

---

## Reserved Motion resources

FanucX Motion currently reserves controller resources including:

```text
PR[90]
PR[93]
R[191]-R[199]
```

Do not allow unrelated TP programs, KAREL programs, Background Logic, PLC logic, HMIs, or external applications to modify these resources during FanucX Motion execution.

See [Reserved Controller Resources](docs/controller/reserved-resources.md) before enabling Motion.

---

## Current limitations

- Python package installation metadata is not included in the initial public release
- one request can be active on a connection at a time
- request pipelining is not supported
- protocol messages are limited by the controller `STRING[254]` buffers
- Motion execution currently supports Motion Group 1
- Motion Joint targets contain exactly six axes
- Motion Cartesian targets do not support extended axes
- controller compatibility depends on software version and installed options

---

## Safety

FanucX Motion commands can move the robot immediately.

Before executing Motion:

- verify the target and units
- verify the Motion Group
- verify the User Frame and Tool Frame
- verify the active Payload configuration
- verify Joint and Cartesian limits
- confirm a clear path and workspace
- confirm that reserved resources are not used by other logic
- test new applications in RoboGuide or under controlled commissioning conditions
- use the controller and cell safety functions required by the installation

FanucX is not safety-rated and does not replace DCS, collision detection, guarding, emergency-stop circuits, enabling devices, safety PLC logic, controller safety logic, commissioning, or the machine risk assessment.

---

## Roadmap

Planned work includes:

- Python packaging and local installation support
- simplified project setup
- additional examples and demonstration applications
- automated testing and usability improvements
- further controller and protocol refinements

---

## Feedback

FanucX is published as an initial public release. Feedback, issue reports, implementation suggestions, and practical use cases are welcome through the repository issue tracker.
