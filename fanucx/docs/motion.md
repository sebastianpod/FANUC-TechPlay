# Motion

FanucX provides current-position feedback, Cartesian reachability checks, Joint motion, Linear motion, motion-state monitoring, and motion abort operations.

The public Motion API is exposed directly through the `Robot` instance:

```python
robot.cartesian()
robot.joints()
robot.is_reachable(...)
robot.movej(...)
robot.movel(...)
robot.abort_motion()
```

---

## Connecting to the robot

```python
from fanucx import Robot


robot = Robot(
    host="192.168.0.10",
    port=12345,
    timeout=5,
)

robot.connect()

try:
    cartesian = robot.cartesian()
    joints = robot.joints()

    print(cartesian)
    print(joints)
finally:
    robot.disconnect()
```

Motion operations require an active connection. Calling an operation before `connect()` or after `disconnect()` raises `RobotNotConnectedError`.

---

# Current position

## Current Cartesian position

Read the current Cartesian TCP position for Motion Group 1:

```python
position = robot.cartesian()
```

Read another motion group explicitly:

```python
position = robot.cartesian(group=2)
```

The returned value is a `CartesianPosition`:

```python
print(position.x)
print(position.y)
print(position.z)
print(position.w)
print(position.p)
print(position.r)
print(position.configuration.value)
```

The current implementation returns exactly:

```text
X;Y;Z;W;P;R;CONFIGURATION
```

Units:

| Component | Unit |
|---|---|
| `x`, `y`, `z` | `mm` |
| `w`, `p`, `r` | `deg` |

The position returned by the controller is the current TCP position relative to the active User Frame, with the active Tool Frame applied.


## Current Joint position

Read the current Joint position for Motion Group 1:

```python
joints = robot.joints()
```

Read another motion group explicitly:

```python
joints = robot.joints(group=2)
```

The returned value is a `JointPosition`:

```python
print(joints.axes)
```

Example:

```text
(-90.0, 45.0, 0.0, 0.0, -90.0, 0.0)
```

The current implementation returns exactly six robot axes:

```text
J1;J2;J3;J4;J5;J6
```

Joint values are expressed in degrees.

---

# Cartesian reachability

Use `is_reachable()` to check whether a Cartesian target is accepted by the controller for an explicit Motion Group, User Frame, and Tool Frame:

```python
reachable = robot.is_reachable(
    target,
    group=1,
    uframe=0,
    utool=1,
)
```

The method returns a Python `bool`:

```python
if robot.is_reachable(target, uframe=1, utool=2):
    print("Target accepted")
else:
    print("Target rejected")
```

The target must be a `CartesianPosition` and cannot contain extended axes.

```python
robot.is_reachable(123)
# TypeError
```

```python
robot.is_reachable(joint_position)
# TypeError
```

The controller check uses `CHECK_EPOS` with the supplied Motion Group, User Frame, and Tool Frame. It does not temporarily modify the controller's active `UFRAME_NUM` or `UTOOL_NUM`.

`UFRAME[0]` represents World Frame. `UTOOL[0]` represents the identity tool transformation at the robot faceplate.

A target rejected by `CHECK_EPOS` is a valid result of the check and returns `False`. It does not raise `RobotOperationError` merely because the target is unreachable.

`is_reachable()` validates a Cartesian endpoint. It does not prove that the complete path is collision-free.

---

# Joint motion

Use `movej()` to execute a Joint motion:

```python
result = robot.movej(
    target,
    speed=100,
    termination="FINE",
    group=1,
    uframe=0,
    utool=1,
)
```

`movej()` accepts either:

- `CartesianPosition`,
- `JointPosition` containing exactly six axes.

The target representation and motion type are independent. A Cartesian target can be executed with a Joint motion, and a Joint target can be stored in the Position Register used by the TP executor.

## Joint target

```python
from fanucx import JointPosition


target = JointPosition(
    (
        -90.0,
        45.0,
        0.0,
        0.0,
        -90.0,
        0.0,
    )
)

result = robot.movej(
    target,
    speed=100,
    termination="FINE",
)
```

## Cartesian target

```python
from fanucx import CartesianPosition


target = CartesianPosition(
    x=500.0,
    y=100.0,
    z=300.0,
    w=180.0,
    p=0.0,
    r=90.0,
    configuration="N U T, 0, 0, 0",
)

result = robot.movej(
    target,
    speed=50,
    termination=25,
    uframe=1,
    utool=2,
)
```

## Joint speed

Joint speed:

- must be `int`,
- cannot be `bool`,
- must be between `1` and `100`,
- is expressed as a percentage.

```python
robot.movej(target, speed=0)
# ValueError
```

```python
robot.movej(target, speed=101)
# ValueError
```

```python
robot.movej(target, speed=10.5)
# TypeError
```

---

# Linear motion

Use `movel()` to execute a Linear motion:

```python
result = robot.movel(
    target,
    speed=2000,
    termination="FINE",
    group=1,
    uframe=0,
    utool=1,
)
```

`movel()` accepts either:

- `CartesianPosition`,
- `JointPosition` containing exactly six axes.

When a Joint target is supplied, the Joint values define the final robot pose. The TP executor still uses a Linear instruction, so the TCP path is interpolated linearly to the resulting endpoint.

## Cartesian target

```python
target = robot.cartesian()

target.z += 100.0

result = robot.movel(
    target,
    speed=2000,
    termination="FINE",
    uframe=robot.uframe.active,
    utool=robot.utool.active,
)
```

## Joint target

```python
target = robot.joints()

result = robot.movel(
    target,
    speed=2000,
    termination=50,
    uframe=0,
    utool=1,
)
```

## Linear speed

Linear speed:

- must be `int`,
- cannot be `bool`,
- must be greater than zero,
- is expressed in `mm/sec`.

FanucX does not enforce a local upper speed limit. If the requested value exceeds the maximum available speed for the configured robot, the FANUC controller limits the executed speed to the supported maximum.

```python
robot.movel(target, speed=0)
# ValueError
```

```python
robot.movel(target, speed=2000.5)
# TypeError
```

---

# Motion termination

Both `movej()` and `movel()` support `FINE` and `CNT` termination.

## FINE

```python
robot.movej(
    target,
    speed=100,
    termination="FINE",
)
```

`"FINE"` is converted internally to the protocol value `-1`.

The integer `-1` is not accepted in the public Python API:

```python
robot.movej(target, termination=-1)
# ValueError
```

## CNT

Pass an integer from `0` to `100`:

```python
robot.movej(
    target,
    speed=100,
    termination=50,
)
```

This executes the TP instruction using:

```text
CNT R[194:FX_TERM]
```

where `R[194]` contains `50`.

Valid CNT values:

```text
0-100
```

Invalid examples:

```python
robot.movej(target, termination=101)
# ValueError
```

```python
robot.movej(target, termination="CNT50")
# TypeError
```

```python
robot.movej(target, termination=True)
# TypeError
```

---

# Motion result

`movej()` and `movel()` wait until the FanucX motion reaches a final state and return:

```python
motion_type, group, status, result, error = robot.movej(...)
```

The return value is a five-element tuple:

```text
MOTION_TYPE;GROUP;STATUS;RESULT;ERROR
```

Example successful Joint motion:

```python
(1, 1, 3, 1, 0)
```

Example successful Linear motion:

```python
(2, 1, 3, 1, 0)
```

## Motion type values

| Value | Meaning |
|---:|---|
| `0` | None |
| `1` | Joint |
| `2` | Linear |

## Motion status values

| Value | Meaning |
|---:|---|
| `0` | Idle |
| `1` | Accepted |
| `2` | Running |
| `3` | Completed |
| `4` | Failed |
| `5` | Aborted |
| `6` | Rejected |

## Motion result values

| Value | Meaning |
|---:|---|
| `0` | No successful result |
| `1` | Motion completed successfully |

The error value is `0` when no motion error has been recorded. A nonzero value contains an internal FanucX or controller status associated with the failed or rejected motion.

---

# Aborting a motion

Abort the active FanucX motion:

```python
motion_type, group, status, result, error = robot.abort_motion()
```

A successful abort returns a final state equivalent to:

```python
(
    2,  # Linear motion
    1,  # Motion Group 1
    5,  # Aborted
    0,  # No successful result
    0,  # Abort completed without an internal error
)
```

`abort_motion()` aborts only the FanucX `FX_MOTION` task. It does not perform a global controller abort and does not intentionally abort unrelated TP or KAREL programs.

An abort is accepted only while the current FanucX motion status is:

```text
1 - Accepted
2 - Running
```

Calling `abort_motion()` without an active FanucX motion is rejected and raises `RobotOperationError`.

Because `movej()` and `movel()` wait for completion in `0.1.0`, applications that need to issue an abort while a motion is running must arrange control flow that can call `abort_motion()` while the motion request is active. Do not share one `Robot` socket concurrently between threads without application-level synchronization.

---

# Motion Groups, User Frames, and Tool Frames

All current-position and motion operations default to Motion Group 1:

```python
robot.cartesian()
robot.joints()
robot.movej(target)
robot.movel(target)
```

A group can be supplied explicitly:

```python
robot.cartesian(group=2)
robot.joints(group=2)
```

```python
robot.movej(
    target,
    group=1,
    uframe=1,
    utool=2,
)
```

Validation rules:

- `group` must be an `int`, cannot be `bool`, and must be greater than zero,
- `uframe` must be an `int`, cannot be `bool`, and must be greater than or equal to zero,
- `utool` must be an `int`, cannot be `bool`, and must be greater than or equal to zero.

The controller validates the maximum available group, User Frame, and Tool Frame numbers.

The `0.1.0` TP motion executor currently transfers Motion Group 1 to the child TP task. Motion execution should therefore be treated as Motion Group 1 functionality until a group-specific TP executor or dynamic lock-mask strategy is implemented and tested.

For Cartesian targets, the supplied `uframe` and `utool` define the coordinate context used by the target and the TP executor.

For Joint targets, Joint values do not depend on User Frame or Tool Frame, but the supplied frame numbers are still stored and applied by `FX_MOTION`.

---

# Target validation

`movej()` and `movel()` accept:

```python
CartesianPosition
JointPosition
```

A `CartesianPosition` target cannot contain extended axes in `0.1.0`:

```python
robot.movej(cartesian_with_extended_axes)
# ValueError
```

A `JointPosition` target must contain exactly six axes:

```python
robot.movej(JointPosition((0.0, 0.0, 0.0, 0.0, 0.0)))
# ValueError
```

Unsupported target types raise `TypeError`:

```python
robot.movej(123)
# TypeError
```

FanucX serializes position values using decimal notation. This prevents small values such as `0.000005` from being transmitted as `5e-06`, which is not accepted by the current KAREL real-number parser.

---

# Internal execution model

FanucX reserves the following controller resources for motion execution.

## Position Registers

| Register | Comment | Purpose |
|---:|---|---|
| `PR[90]` | `FX_TARGET_IN` | Input target written by KAREL |
| `PR[93]` | `FX_TARGET_EXEC` | Frozen target copied by the TP executor |

`PR[91]`, `PR[92]`, `PR[94]`, and `PR[95]` are reserved for future Circular motion support.

## Numeric Registers

| Register | Comment | Purpose |
|---:|---|---|
| `R[191]` | `FX_MOT_TYPE` | Motion type |
| `R[192]` | `FX_MOT_GRP` | Motion group number |
| `R[193]` | `FX_SPEED` | Joint percentage or Linear `mm/sec` |
| `R[194]` | `FX_TERM` | `-1` for FINE or `0-100` for CNT |
| `R[195]` | `FX_MOT_STATUS` | Current motion status |
| `R[196]` | `FX_MOT_RESULT` | Motion result |
| `R[197]` | `FX_MOT_ERROR` | Motion error code |
| `R[198]` | `FX_UFRAME_NUM` | User Frame used by the motion |
| `R[199]` | `FX_UTOOL_NUM` | Tool Frame used by the motion |

## TP executor

The TP program is named:

```text
FX_MOTION
```

KAREL writes the accepted target to `PR[90]` and request parameters to `R[191-199]`. It then starts `FX_MOTION` through `RUN_TASK`.

At the beginning of execution, `FX_MOTION` copies:

```text
PR[90] -> PR[93]
```

The movement uses only `PR[93]`. This prevents a later write to `PR[90]` from changing a target that has already been accepted for execution.

Only one FanucX motion may be `ACCEPTED` or `RUNNING` at a time. A second start request is rejected.

Applications, TP programs, KAREL programs, PLC logic, and external systems must not modify the reserved registers while a FanucX motion is active.

---

# Protocol commands

| Code | Operation |
|---:|---|
| `700` | Read current Cartesian position |
| `701` | Read current Joint position |
| `702` | Check Cartesian target using `CHECK_EPOS` |
| `710` | Start Joint motion |
| `711` | Start Linear motion |
| `720` | Read current FanucX motion status |
| `721` | Abort current FanucX motion |

The command range `700-799` is reserved for Motion operations.

---

# Exceptions

Motion operations can raise:

| Exception | Typical cause |
|---|---|
| `RobotNotConnectedError` | Request made without an active robot connection |
| `RobotConnectionError` | Connection setup failed |
| `RobotCommunicationError` | Communication failed after connecting |
| `RobotOperationError` | Controller rejected the group, frame, target, motion start, status operation, or abort |
| `RobotProtocolError` | Controller returned an invalid position, reachability, or motion-status response |
| `TypeError` | Invalid argument or target type |
| `ValueError` | Invalid range, unsupported axis count, extended axes, speed, or termination |

A successful motion-start response means that the request was accepted and the TP executor started. It does not itself prove that the motion completed. `movej()` and `movel()` continue reading the motion status until a final state is reached.

---

# Safety and limitations

Motion commands can move the robot immediately.

Before executing a motion:

- verify the target and units,
- verify the selected Motion Group,
- verify the User Frame and Tool Frame,
- verify the active Payload configuration,
- verify Joint and Cartesian limits,
- confirm a clear path and workspace,
- avoid concurrent modification of reserved Position and Numeric Registers,
- test new applications in RoboGuide or under controlled commissioning conditions,
- use controller safety functions and cell risk controls appropriate to the installation.

`CHECK_EPOS` does not prove that the complete Linear path is collision-free.

FanucX Motion operations are not safety-rated and do not replace:

- DCS,
- collision detection,
- guarding,
- emergency-stop circuits,
- enabling devices,
- safety PLC logic,
- controller safety logic,
- machine risk assessment.

A completed motion status confirms that the FanucX TP executor reached its completion logic. It does not independently verify process quality, tooling condition, payload correctness, or collision-free operation.

---

# Quick reference

```python
from fanucx import (
    CartesianPosition,
    JointPosition,
    Robot,
)


robot = Robot(
    host="192.168.0.10",
    port=12345,
    timeout=5,
)

robot.connect()

try:
    # Current positions
    cartesian = robot.cartesian()
    joints = robot.joints()

    # Reachability
    reachable = robot.is_reachable(
        cartesian,
        group=1,
        uframe=robot.uframe.active,
        utool=robot.utool.active,
    )

    # Joint motion with a Joint target and FINE
    joint_target = JointPosition(
        (-90.0, 45.0, 0.0, 0.0, -90.0, 0.0)
    )

    joint_result = robot.movej(
        joint_target,
        speed=100,
        termination="FINE",
        group=1,
        uframe=0,
        utool=1,
    )

    # Joint motion with CNT50
    robot.movej(
        joint_target,
        speed=100,
        termination=50,
    )

    # Linear motion with a Cartesian target
    linear_target = CartesianPosition(
        x=500.0,
        y=100.0,
        z=300.0,
        w=180.0,
        p=0.0,
        r=90.0,
        configuration="N U T, 0, 0, 0",
    )

    linear_result = robot.movel(
        linear_target,
        speed=2000,
        termination="FINE",
        group=1,
        uframe=1,
        utool=2,
    )

    # Returned motion state
    motion_type, group, status, result, error = linear_result

    print(motion_type)
    print(group)
    print(status)
    print(result)
    print(error)

finally:
    robot.disconnect()
```
