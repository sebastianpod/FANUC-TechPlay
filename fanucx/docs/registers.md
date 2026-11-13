# Registers

FanucX provides Pythonic, indexed access to FANUC numeric, string, and position registers. Register values and comments are exposed through the `Robot` instance using `robot.r`, `robot.sr`, and `robot.pr`.

## Overview

| FANUC resource | FanucX API | Value type |
|---|---|---|
| Numeric Register `R[n]` | `robot.r[n]` | `int` or `float` |
| String Register `SR[n]` | `robot.sr[n]` | `str` |
| Position Register `PR[n]` | `robot.pr[n]` | `CartesianPosition` or `JointPosition` |
| Numeric Register comment | `robot.r.comment[n]` | `str` |
| String Register comment | `robot.sr.comment[n]` | `str` |
| Position Register comment | `robot.pr.comment[n]` | `str` |

Square-bracket access, such as robot.pr[1], always reads or writes Position Registers for Motion Group 1. To access a Position Register for another motion group, use get_cartesian(), set_cartesian(), get_joint(), or set_joint() and pass the required group number explicitly.

```python
position = robot.pr[1]  # Motion Group 1

position = robot.pr.get_cartesian(1, group=2)  # Motion Group 2
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
    print(robot.r[1])
finally:
    robot.disconnect()
```

Register operations require an active connection. Calling an operation before `connect()` or after `disconnect()` raises `RobotNotConnectedError`.

---

# Numeric Registers

Numeric Registers are available through:

```python
robot.r
```

## Reading a Numeric Register

```python
value = robot.r[1]
print(value)
```

FanucX strips surrounding whitespace from the controller response and attempts to return an `int`. If integer conversion is not possible, FanucX returns a `float`.

```python
integer_value = robot.r[1]
floating_value = robot.r[2]

print(type(integer_value))
print(type(floating_value))
```

## Writing a Numeric Register

```python
robot.r[1] = 25
robot.r[2] = 12.5
```

Accepted Python types:

- `int`
- `float`

Boolean values are rejected even though `bool` is a subclass of `int` in Python.

```python
robot.r[1] = True
# TypeError: Numeric Register value must be an integer or float,
# received bool.
```

## Numeric Register comments

Read a comment:

```python
comment = robot.r.comment[1]
print(comment)
```

Write a comment:

```python
robot.r.comment[1] = "PART COUNT"
```

Clear a comment:

```python
robot.r.comment[1] = ""
```

Numeric Register comments:

- must be `str`,
- cannot exceed 16 characters,
- cannot contain `|`, because `|` is reserved by the FanucX protocol.

```python
robot.r.comment[1] = "THIS COMMENT IS TOO LONG"
# ValueError
```

## Complete Numeric Register example

```python
from fanucx import Robot


robot = Robot("192.168.0.10", 12345, timeout=5)
robot.connect()

try:
    robot.r[10] = 100
    robot.r.comment[10] = "PART COUNT"

    print(robot.r[10])
    print(robot.r.comment[10])
finally:
    robot.disconnect()
```

---

# String Registers

String Registers are available through:

```python
robot.sr
```

## Reading a String Register

```python
value = robot.sr[1]
print(value)
```

The returned value is a Python `str`.

## Writing a String Register

```python
robot.sr[1] = "FANUCX"
```

String Register values:

- must be `str`,
- cannot exceed 240 characters,
- cannot contain `|`.

```python
robot.sr[1] = 123
# TypeError
```

```python
robot.sr[1] = "VALUE|WITH|SEPARATOR"
# ValueError
```

## String Register comments

Read a comment:

```python
comment = robot.sr.comment[1]
```

Write a comment:

```python
robot.sr.comment[1] = "PART NAME"
```

Clear a comment:

```python
robot.sr.comment[1] = ""
```

String Register comments:

- must be `str`,
- cannot exceed 16 characters,
- cannot contain `|`.

---

# Position Registers

Position Registers are available through:

```python
robot.pr
```

FanucX supports Cartesian and Joint Position Registers.

## Automatic Position Register Access

For Motion Group 1, use indexed access:

```python
position = robot.pr[1]
```

Before reading the position value, FanucX asks the controller for the position representation type and the number of axes.

FANUC identifies position representations using numeric values returned
by the KAREL position-type interface:

| Position type | KAREL representation | FanucX result |
|---:|---|---|
| `2` | `XYZWPR` | `CartesianPosition` |
| `6` | `XYZWPREXT` | `CartesianPosition` |
| `9` | `JOINTPOS` | `JointPosition` |

`XYZWPR` represents a Cartesian position using `X, Y, Z, W, P, R`.

`XYZWPREXT` extends the Cartesian representation with up to three extended-axis values: `X, Y, Z, W, P, R, EXT1, EXT2, EXT3`. 

`JOINTPOS` represents a position as individual joint-axis values.

FanucX automatically returns the appropriate Python object:

```python
position = robot.pr[1]

if isinstance(position, CartesianPosition):
    print(position.x)
    print(position.configuration.value)
    print(position.extended_axes)

elif isinstance(position, JointPosition):
    print(position.axes)
```

Indexed assignment accepts either supported position model:

```python
robot.pr[1] = cartesian_position
robot.pr[2] = joint_position
```

If the controller reports a position type other than 2, 6, or 9, FanucX raises `RobotProtocolError`.

Most applications do not need to inspect the numeric FANUC position type directly. Use `get_type()` only when the representation type and axis count are required:

```python
position_type, number_of_axes = robot.pr.get_type(
    1,
    group=1,
)
```

The method returns:

```python
(position_type, number_of_axes)
```

For a `JOINTPOS` representation, `number_of_axes` identifies the number of axes returned by the controller.

Square-bracket access always uses Motion Group 1. To use another motion group, call `get_cartesian()`, `set_cartesian()`, `get_joint()`, or `set_joint()` and pass group explicitly.

## Cartesian Position Registers

## Reading a Cartesian Position Register

```python
position = robot.pr.get_cartesian(
    1,
    group=1,
)

print(position.x)
print(position.y)
print(position.z)
print(position.w)
print(position.p)
print(position.r)
print(position.configuration.value)
print(position.extended_axes)
```

The returned object is a `CartesianPosition`.

## Creating a Cartesian position

```python
from fanucx import CartesianPosition


position = CartesianPosition(
    x=500.0,
    y=100.0,
    z=300.0,
    w=180.0,
    p=0.0,
    r=90.0,
    configuration="N U T, 0, 0, 0",
)
```

A Cartesian position contains:

| Attribute | Description |
|---|---|
| `x` | X coordinate |
| `y` | Y coordinate |
| `z` | Z coordinate |
| `w` | W orientation |
| `p` | P orientation |
| `r` | R orientation |
| `configuration` | `CartesianConfiguration` object containing the FANUC posture flags and turn numbers |
| `extended_axes` | Tuple of zero to three extended-axis values |

### Cartesian Configuration

A Cartesian position includes a FANUC configuration describing the robot posture used to reach the position.

The expected format is:

`<N|F> <U|D> <T|B>, TURN_1, TURN_2, TURN_3`

The three posture flags are separated by spaces. The posture section is followed by a comma and three integer turn values.

Examples:

`N U T, 0, 0, 0`

`F D B, -1, 0, 1`

The first three fields accept the following values:

| Field | Allowed values | Meaning |
|---|---|---|
| Flip | `N` or `F` | Non-flip or flip configuration |
| Up/Down | `U` or `D` | Arm-up or arm-down configuration |
| Top/Bottom | `T` or `B` | Top or bottom configuration |

The final three fields are integer turn values:

`TURN_1, TURN_2, TURN_3`

Example:

`N U T, 0, 0, 0`

Another example:

`F D B, -1, 0, 1`

When FanucX reads a Cartesian Position Register, the configuration is returned as a `CartesianConfiguration` object:

```python
position.configuration
```

The original FANUC configuration string is available through:

```python
position.configuration.value
```

Example:

```python
print(position.configuration.value)
```

When creating a `CartesianPosition`, the configuration can be provided as a string:

```python
position = CartesianPosition(
    x=500.0,
    y=100.0,
    z=300.0,
    w=180.0,
    p=0.0,
    r=90.0,
    configuration="N U T, 0, 0, 0",
)
```

The configuration can also be provided as an existing `CartesianConfiguration` object:

```python
from fanucx import CartesianConfiguration, CartesianPosition

configuration = CartesianConfiguration(
    "N U T, 0, 0, 0"
)

position = CartesianPosition(
    x=500.0,
    y=100.0,
    z=300.0,
    w=180.0,
    p=0.0,
    r=90.0,
    configuration=configuration,
)
```

Identical Cartesian coordinates can correspond to different robot postures. Applications should preserve the configuration returned by the controller unless a different posture is intentionally required.

The `CartesianConfiguration` class stores the configuration string without validating it locally in Python. Before writing the position, the FanucX KAREL server validates the posture flags and integer turn values. Invalid configuration data is rejected before the position is assigned. The FANUC controller may still reject a correctly formatted configuration if it is incompatible with the selected position or robot configuration.

Passing a value other than `str` or `CartesianConfiguration` as the configuration argument raises `TypeError`.

## Writing a Cartesian Position Register

```python
robot.pr.set_cartesian(
    1,
    position,
    group=1,
)
```

For Motion Group 1, indexed assignment is equivalent:

```python
robot.pr[1] = position
```

## Extended axes

A Cartesian Position Register response may contain zero to three extended-axis fields. FanucX stores these fields as a tuple in `extended_axes`.

```python
position = CartesianPosition(
    x=500.0,
    y=100.0,
    z=300.0,
    w=180.0,
    p=0.0,
    r=90.0,
    configuration="N U T, 0, 0, 0",
    extended_axes=(1000.0, 0.0, 45.0),
)
```

The availability and interpretation of extended axes depend on the controller and selected motion group.

---

# Joint Position Registers

## Reading a Joint Position Register

```python
position = robot.pr.get_joint(
    1,
    group=1,
)

print(position.axes)
```

The returned object is a `JointPosition`. Its `axes` attribute contains a tuple of axis values.

```python
# Example result
(-90.0, 10.0, 25.0, 0.0, -90.0, 0.0)
```

FanucX accepts controller responses containing between 1 and 9 axes.

## Creating a Joint position

```python
from fanucx import JointPosition


position = JointPosition(
    (
        -90.0,
        10.0,
        25.0,
        0.0,
        -90.0,
        0.0,
    )
)
```

## Writing a Joint Position Register

```python
robot.pr.set_joint(
    1,
    position,
    group=1,
)
```

For Motion Group 1:

```python
robot.pr[1] = position
```

A `JointPosition` written to the controller must contain between 1 and 9 axis values. The axis-count validation is performed when `set_joint()` or indexed assignment is used. An invalid axis count raises `ValueError`.

---

# Position Register comments

Read a comment:

```python
comment = robot.pr.comment[1]
```

Write a comment:

```python
robot.pr.comment[1] = "PICK POSITION"
```

Clear a comment:

```python
robot.pr.comment[1] = ""
```

Position Register comments:

- must be `str`,
- cannot exceed 16 characters,
- cannot contain `|`.

```python
robot.pr.comment[1] = "THIS COMMENT IS TOO LONG"
# ValueError
```

Position Register comments are global register metadata and do not accept a motion-group argument.

---

# Working with multiple motion groups

Indexed Position Register access uses Motion Group 1:

```python
position = robot.pr[1]
robot.pr[1] = position
```

Use explicit methods for another group:

```python
position = robot.pr.get_cartesian(
    1,
    group=2,
)

robot.pr.set_cartesian(
    1,
    position,
    group=2,
)
```

Joint positions use the same pattern:

```python
position = robot.pr.get_joint(
    1,
    group=2,
)

robot.pr.set_joint(
    1,
    position,
    group=2,
)
```

`group` must be a positive integer and cannot be `bool`.

---

# Validation

FanucX validates register indices before sending a request to the controller.

A register index:

- must be an `int`,
- cannot be a `bool`,
- must be greater than zero.

```python
robot.r[0]
# ValueError
```

```python
robot.r["1"]
# TypeError
```

```python
robot.pr.get_cartesian(1, group=True)
# TypeError
```

Local validation does not know the controller's configured register count or number of motion groups. A positive index can therefore pass local validation and still be rejected by the controller.

---

# Exceptions

Register operations can raise the following public exceptions:

| Exception | Typical cause |
|---|---|
| `RobotNotConnectedError` | Request made without an active robot connection |
| `RobotConnectionError` | Connection setup failed |
| `RobotCommunicationError` | Communication failed after connecting |
| `RobotOperationError` | Controller rejected an otherwise valid request |
| `RobotProtocolError` | Controller returned an unexpected or unsupported response |
| `TypeError` | Invalid Python argument type |
| `ValueError` | Invalid locally validated value or range |

Example:

```python
from fanucx import RobotOperationError


try:
    value = robot.r[999999]
except RobotOperationError as error:
    print(error)
```

---

# Reserved Registers

FanucX reserves several Position Registers and Numeric Registers for its motion subsystem.

Application code, TP programs, KAREL programs, PLC logic, and other external systems should not use these registers for unrelated data.

Reserved registers must not be modified while a FanucX motion request is active.

## Reserved Position Registers

| Register | Comment | Purpose |
|---:|---|---|
| `PR[90]` | `FX_TARGET_IN` | Input target for joint or linear motion |
| `PR[91]` | `FX_CIRC_VIA_IN` | Circular-motion via point |
| `PR[92]` | `FX_CIRC_END_IN` | Circular-motion endpoint |
| `PR[93]` | `FX_TARGET_EXEC` | Frozen execution target for joint or linear motion |
| `PR[94]` | `FX_CIRC_VIA_EXEC` | Frozen circular-motion via point |
| `PR[95]` | `FX_CIRC_END_EXEC` | Frozen circular-motion endpoint |

## Reserved Numeric Registers

| Register | Comment | Purpose |
|---:|---|---|
| `R[190]` | `FX_REQ_ID` | Motion request identifier |
| `R[191]` | `FX_MOT_TYPE` | Requested motion type |
| `R[192]` | `FX_MOT_GRP` | Motion group number |
| `R[193]` | `FX_SPEED` | Motion speed |
| `R[194]` | `FX_TERM` | Motion termination type or value |
| `R[195]` | `FX_MOT_STATUS` | Current FanucX motion status |
| `R[196]` | `FX_MOT_RESULT` | Motion result |
| `R[197]` | `FX_MOT_ERROR` | Motion error code |
| `R[198]` | `FX_UFRAME_NUM` | User Frame number used by the motion |
| `R[199]` | `FX_UTOOL_NUM` | Tool Frame number used by the motion |

### Access through the register API

Reserved Numeric Registers remain technically accessible through `robot.r`:

```python
request_id = robot.r[190]
motion_status = robot.r[195]
motion_error = robot.r[197]
```

Direct access does not make these registers application-owned. They remain internal resources of the FanucX motion subsystem.

Application code should use the public `robot.motion` API for starting, monitoring, and aborting motion instead of writing directly to `R[190-199]`.

Reading reserved status registers can be useful for diagnostics. Modifying them may corrupt the motion state or cause the Python client, KAREL server, and TP motion executor to report inconsistent results.

---

# Safety and data ownership

Writing a Position Register does not move the robot. It only changes stored position data. A TP or KAREL program can later use that data in a motion instruction.

Before writing registers:

- confirm the selected register number,
- confirm the selected motion group,
- avoid overwriting registers used by production programs,
- define clear ownership between FanucX, TP programs, KAREL programs, and PLC logic,
- back up important controller data,
- do not modify FanucX-reserved registers while motion is active.

---

# Quick reference

```python
# Numeric Register
value = robot.r[1]
robot.r[1] = 25
robot.r.comment[1] = "PART COUNT"

# String Register
text = robot.sr[1]
robot.sr[1] = "FANUCX"
robot.sr.comment[1] = "PART NAME"

# Position Register, automatic type detection, group 1
position = robot.pr[1]
robot.pr[1] = position

# Explicit Cartesian access
cartesian = robot.pr.get_cartesian(1, group=1)
robot.pr.set_cartesian(1, cartesian, group=1)

# Explicit joint access
joint = robot.pr.get_joint(1, group=1)
robot.pr.set_joint(1, joint, group=1)

# Position Register, automatic type detection, Motion Group 1
position = robot.pr[1]
robot.pr[1] = position
robot.pr.comment[1] = "PICK POSITION"

# Explicit Cartesian access
cartesian = robot.pr.get_cartesian(1, group=1)
robot.pr.set_cartesian(1, cartesian, group=1)

# Explicit joint access
joint = robot.pr.get_joint(1, group=1)
robot.pr.set_joint(1, joint, group=1)

# Inspect the FANUC position representation
position_type, number_of_axes = robot.pr.get_type(1, group=1)
```

---
