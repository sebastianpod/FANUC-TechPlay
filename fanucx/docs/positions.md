# Position types

FanucX represents robot positions with three public classes:

```python
from fanucx import (
    CartesianConfiguration,
    CartesianPosition,
    JointPosition,
)
```

These classes are used by Position Registers and Motion operations.

---

## CartesianPosition

`CartesianPosition` represents a Cartesian robot position and orientation.

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
```

### Fields

| Field | Description | Unit |
|---|---|---|
| `x` | Position along the X axis | `mm` |
| `y` | Position along the Y axis | `mm` |
| `z` | Position along the Z axis | `mm` |
| `w` | Rotation around the X axis | `deg` |
| `p` | Rotation around the Y axis | `deg` |
| `r` | Rotation around the Z axis | `deg` |
| `configuration` | FANUC Cartesian configuration | Not applicable |
| `extended_axes` | Optional additional-axis values | Controller dependent |

Read the values directly:

```python
print(target.x)
print(target.y)
print(target.z)
print(target.w)
print(target.p)
print(target.r)
print(target.configuration.value)
print(target.extended_axes)
```

A Cartesian position returned by FanucX contains a `CartesianConfiguration` object in `configuration`.

---

## CartesianConfiguration

`CartesianConfiguration` stores the FANUC configuration string associated with a Cartesian position.

Example configuration:

```text
N U T, 0, 0, 0
```

Access its text value through:

```python
configuration_text = position.configuration.value
```

A configuration can be supplied as text when creating a `CartesianPosition`:

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

The configuration is part of the Cartesian target. Two Cartesian positions with identical `x`, `y`, `z`, `w`, `p`, and `r` values can represent different robot postures when their configurations differ.

Use a configuration that is valid for the target and robot setup.

---

## Extended axes

Additional Cartesian axes can be stored in `extended_axes` as a tuple:

```python
position = CartesianPosition(
    x=500.0,
    y=100.0,
    z=300.0,
    w=180.0,
    p=0.0,
    r=90.0,
    configuration="N U T, 0, 0, 0",
    extended_axes=(100.0, 250.0),
)
```

Read them with:

```python
print(position.extended_axes)
```

Example result:

```python
(100.0, 250.0)
```

FanucX position parsing supports up to three Cartesian extended-axis values.

Extended axes can be used with Position Register operations when supported by the controller and register data. Motion targets and `is_reachable()` currently reject a `CartesianPosition` containing extended axes:

```python
robot.movej(position)
# ValueError
```

```python
robot.is_reachable(position)
# ValueError
```

---

## JointPosition

`JointPosition` represents robot axis values as an ordered tuple.

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
```

Access the axis values through `axes`:

```python
print(target.axes)
```

Example result:

```python
(-90.0, 45.0, 0.0, 0.0, -90.0, 0.0)
```

Axis values are ordered as:

```text
J1, J2, J3, J4, J5, J6
```

Joint values are expressed in degrees.

The shared position protocol supports between one and nine Joint values for Position Register data. Motion operations require exactly six axes:

```python
robot.movej(
    JointPosition((0.0, 0.0, 0.0, 0.0, 0.0))
)
# ValueError
```

---

## Reading current positions

Read the current Cartesian position:

```python
cartesian = robot.cartesian(group=1)
```

Read the current Joint position:

```python
joints = robot.joints(group=1)
```

`robot.cartesian()` returns a `CartesianPosition`.

`robot.joints()` returns a six-axis `JointPosition`.

---

## Using positions with Motion

Both `movej()` and `movel()` accept either position representation.

### Joint motion with a JointPosition

```python
result = robot.movej(
    JointPosition((-90.0, 45.0, 0.0, 0.0, -90.0, 0.0)),
    speed=100,
    termination="FINE",
)
```

### Joint motion with a CartesianPosition

```python
result = robot.movej(
    CartesianPosition(
        x=500.0,
        y=100.0,
        z=300.0,
        w=180.0,
        p=0.0,
        r=90.0,
        configuration="N U T, 0, 0, 0",
    ),
    speed=50,
    termination=25,
    uframe=1,
    utool=2,
)
```

### Linear motion with a CartesianPosition

```python
result = robot.movel(
    CartesianPosition(
        x=500.0,
        y=100.0,
        z=300.0,
        w=180.0,
        p=0.0,
        r=90.0,
        configuration="N U T, 0, 0, 0",
    ),
    speed=2000,
    termination="FINE",
    uframe=1,
    utool=2,
)
```

### Linear motion with a JointPosition

```python
result = robot.movel(
    JointPosition((-90.0, 45.0, 0.0, 0.0, -90.0, 0.0)),
    speed=2000,
    termination=50,
)
```

The position representation does not determine the motion type. `movej()` always executes a Joint motion and `movel()` always executes a Linear motion.

---

## Using positions with Position Registers

Read a Position Register:

```python
position = robot.pr[1]
```

The result is either:

```python
CartesianPosition
```

or:

```python
JointPosition
```

Write a Cartesian position:

```python
robot.pr[1] = CartesianPosition(
    x=500.0,
    y=100.0,
    z=300.0,
    w=180.0,
    p=0.0,
    r=90.0,
    configuration="N U T, 0, 0, 0",
)
```

Write a Joint position:

```python
robot.pr[1] = JointPosition(
    (-90.0, 45.0, 0.0, 0.0, -90.0, 0.0)
)
```

See `registers.md` for the complete Position Register API.

---

## Cartesian and Joint representations

Use `CartesianPosition` when the target is naturally defined by TCP coordinates and orientation:

```python
CartesianPosition(
    x=500.0,
    y=100.0,
    z=300.0,
    w=180.0,
    p=0.0,
    r=90.0,
    configuration="N U T, 0, 0, 0",
)
```

Use `JointPosition` when the target is naturally defined by robot axis values:

```python
JointPosition(
    (-90.0, 45.0, 0.0, 0.0, -90.0, 0.0)
)
```

A `CartesianPosition` defines the TCP pose in a selected User Frame and Tool Frame context.

A `JointPosition` defines robot axis values directly and does not depend on the User Frame or Tool Frame for its axis values.

---

## Validation and exceptions

Unsupported position types raise `TypeError`:

```python
robot.movej(123)
# TypeError
```

An invalid Joint axis count for Motion raises `ValueError`:

```python
robot.movej(
    JointPosition((0.0, 0.0, 0.0, 0.0, 0.0))
)
# ValueError
```

Cartesian extended axes are rejected by Motion and reachability operations:

```python
robot.movel(cartesian_with_extended_axes)
# ValueError
```

Invalid position data returned by the controller raises `RobotProtocolError`.

---

## Quick reference

```python
from fanucx import (
    CartesianPosition,
    JointPosition,
)


cartesian = CartesianPosition(
    x=500.0,
    y=100.0,
    z=300.0,
    w=180.0,
    p=0.0,
    r=90.0,
    configuration="N U T, 0, 0, 0",
)

joints = JointPosition(
    (-90.0, 45.0, 0.0, 0.0, -90.0, 0.0)
)

print(cartesian.x)
print(cartesian.configuration.value)
print(joints.axes)
```
