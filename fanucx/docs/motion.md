# Motion

FanucX provides current-position feedback, Cartesian reachability checks, Joint motion, Linear motion, motion result reporting, and motion abort operations.

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

The returned Cartesian position contains:

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

The returned Joint position contains exactly six axes:

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

The method returns `True` when the controller accepts the target and `False` when the target is rejected. 

An unreachable target is a valid check result and does not raise `RobotOperationError`. 

`UFRAME[0]` represents World Frame. `UTOOL[0]` represents the tool origin at the robot faceplate.

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

- `CartesianPosition` without extended axes,
- `JointPosition` containing exactly six axes.

The target representation does not determine the motion type. In both cases, `movej()` executes a Joint motion to the specified target.

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

result = robot.movej(target, speed=100, termination="FINE")
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

- `CartesianPosition` without extended axes,
- `JointPosition` containing exactly six axes.

The target representation does not determine the motion type. In both cases, `movel()` executes a Linear motion to the specified target.

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

Use `"FINE"` to request exact termination at the target.

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

```python
(motion_type, group, status, result, error)
```

The tuple contains:

| Field | Description |
|---|---|
| `motion_type` | Executed motion type |
| `group` | Motion Group number |
| `status` | Final motion status |
| `result` | Motion result |
| `error` | Motion error code |

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
    motion_type,
    group,
    5,  # Aborted
    0,  # No successful result
    0,  # No abort error
)
```

The returned `motion_type` and `group` identify the motion that was aborted.

`abort_motion()` stops only the active FanucX motion. It does not perform a global controller abort or intentionally stop unrelated controller programs.

An abort is accepted only while the current FanucX motion status is:

```text
1 - Accepted
2 - Running
```

Calling `abort_motion()` without an active FanucX motion is rejected and raises `RobotOperationError`.

---

# Motion Groups, User Frames, and Tool Frames

Current-position and reachability operations default to Motion Group 1:

```python
cartesian = robot.cartesian()
joints = robot.joints()

reachable = robot.is_reachable(
    target,
    uframe=0,
    utool=1,
)
```

Another Motion Group can be selected explicitly for current-position and reachability operations:

```python
cartesian = robot.cartesian(group=2)
joints = robot.joints(group=2)

reachable = robot.is_reachable(
    target,
    group=2,
    uframe=1,
    utool=1,
)
```

Motion execution supports Motion Group 1:

```python
robot.movej(
    target,
    group=1,
    uframe=1,
    utool=2,
)

robot.movel(
    target,
    group=1,
    uframe=1,
    utool=2,
)
```

For all operations, `group`:

- must be an `int`,
- cannot be `bool`,
- must be greater than zero.

For operations accepting frame arguments, `uframe` and `utool`:

- must be `int`,
- cannot be `bool`,
- must be greater than or equal to zero.

The controller validates the maximum available Motion Group, User Frame, and Tool Frame numbers.

Motion execution currently supports only Motion Group 1. Passing another group number to `movej()` or `movel()` raises `ValueError`.

For a `CartesianPosition` target, `uframe` and `utool` define the coordinate system and tool used to interpret and execute the target.

For a `JointPosition` target, the axis values do not depend on User Frame or Tool Frame. The supplied frame numbers are still applied during motion execution.

---

# Target validation

`movej()` and `movel()` accept:

- `CartesianPosition` without extended axes,
- `JointPosition` containing exactly six axes.

A `CartesianPosition` motion target cannot contain extended axes:

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
| `ValueError` | Invalid range, unsupported Motion Group, unsupported axis count, extended axes, speed, or termination |

`movej()` and `movel()` continue reading the motion state until a final status is reached. The returned tuple contains the final motion state reported by the controller.

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

A successful `is_reachable()` result validates the target position only. It does not confirm that the complete motion path is collision-free.

FanucX uses reserved controller Position Registers and Numeric Registers for motion execution. TP programs, KAREL programs, PLC logic, and other external applications must not modify these resources while a FanucX motion is active.

FanucX Motion operations are not safety-rated and do not replace:

- DCS,
- collision detection,
- guarding,
- emergency-stop circuits,
- enabling devices,
- safety PLC logic,
- controller safety logic,
- machine risk assessment.

A completed motion status confirms that FanucX reached the end of its motion execution logic. It does not independently verify process quality, tooling condition, payload configuration, or collision-free operation.

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

    if not reachable:
        print("Target rejected")

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
