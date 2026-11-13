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

## Automatic Position Register access

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
`XYZWPREXT` extends the Cartesian representation with up to three extended-axis values: `X, Y, Z, W, P, R, EXT1, EXT2, EXT3`. `JOINTPOS` represents a position as individual joint-axis values.

# Cartesian Position Registers

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
| `configuration` | `CartesianConfiguration` object |
| `extended_axes` | Tuple of zero to three extended-axis values |

The `configuration` argument accepts either:

- a configuration string,
- an existing `CartesianConfiguration` object.

```python
from fanucx import CartesianConfiguration, CartesianPosition


configuration = CartesianConfiguration("N U T, 0, 0, 0")

position = CartesianPosition(
    500.0,
    100.0,
    300.0,
    180.0,
    0.0,
    90.0,
    configuration,
)
```

Any other configuration type raises `TypeError`.

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

A `JointPosition` must contain between 1 and 9 axis values. An invalid axis count raises `ValueError`.

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

# Reserved Position Registers

FanucX reserves the following Position Registers for its motion subsystem:

| Register | Comment | Purpose |
|---:|---|---|
| `PR[90]` | `FX_TARGET_IN` | Input target for joint or linear motion |
| `PR[91]` | `FX_CIRC_VIA_IN` | Circular-motion via point |
| `PR[92]` | `FX_CIRC_END_IN` | Circular-motion endpoint |
| `PR[93]` | `FX_TARGET_EXEC` | Frozen execution target |
| `PR[94]` | `FX_CIRC_VIA_EXEC` | Frozen circular via point |
| `PR[95]` | `FX_CIRC_END_EXEC` | Frozen circular endpoint |

Application code and controller programs should not use `PR[90-95]` for unrelated data. These registers must not be modified while a FanucX motion request is active.

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

# Position Register metadata
position_type, number_of_axes = robot.pr.get_type(1, group=1)
comment = robot.pr.comment[1]
robot.pr.comment[1] = "PICK POSITION"
```

---

## Known implementation note

Before publishing, correct the error-message expression in `_serialize_cartesian_position()`.

Current code:

```python
raise TypeError(
    f"Expected CartesianPosition, received {type(position.__name__)}"
)
```

Recommended code:

```python
raise TypeError(
    "Expected CartesianPosition, "
    f"received {type(position).__name__}."
)
```

The current expression attempts to access `position.__name__` on an instance and can raise `AttributeError` instead of the intended `TypeError`.
