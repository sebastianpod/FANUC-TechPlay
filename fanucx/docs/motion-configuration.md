# Motion Configuration

FanucX provides Pythonic access to FANUC motion configuration resources:

- User Frames,
- Tool Frames,
- Payload Schedules,
- active User Frame, Tool Frame, and Payload selections.

Motion configuration resources are exposed through the `Robot` instance using:

```python
robot.uframe
robot.utool
robot.payload
```

## Overview

| FANUC resource | FanucX API | Value type |
|---|---|---|
| User Frame `UFRAME[n]` | `robot.uframe[n]` | `CartesianPosition` |
| User Frame comment | `robot.uframe.comment[n]` | `str` |
| Active User Frame | `robot.uframe.active` | `int` |
| Tool Frame `UTOOL[n]` | `robot.utool[n]` | `CartesianPosition` |
| Tool Frame comment | `robot.utool.comment[n]` | `str` |
| Active Tool Frame | `robot.utool.active` | `int` |
| Payload Schedule `PAYLOAD[n]` | `robot.payload[n]` | `Payload` |
| Payload comment | `robot.payload.comment[n]` | `str` |
| Active Payload | `robot.payload.active` | `int` |

Square-bracket access always uses Motion Group 1:

```python
user_frame = robot.uframe[1]
tool_frame = robot.utool[1]
payload = robot.payload[1]
```

To access another motion group, use the explicit `get()` and `set()` methods:

```python
user_frame = robot.uframe.get(1, group=2)
tool_frame = robot.utool.get(1, group=2)
payload = robot.payload.get(1, group=2)
```

The `.active` properties also use Motion Group 1:

```python
active_user_frame = robot.uframe.active
active_tool_frame = robot.utool.active
active_payload = robot.payload.active
```

For another motion group, use `get_active()` and `set_active()`.

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
    print(robot.uframe.active)
    print(robot.utool.active)
    print(robot.payload.active)
finally:
    robot.disconnect()
```

Motion configuration operations require an active connection. Calling an operation before `connect()` or after `disconnect()` raises `RobotNotConnectedError`.

---

# Frame representation

User Frames and Tool Frames are represented using `CartesianPosition`:

```python
from fanucx import CartesianPosition
```

A frame contains the following components:

| Attribute | Unit | Description |
|---|---|---|
| `x` | `mm` | X translation |
| `y` | `mm` | Y translation |
| `z` | `mm` | Z translation |
| `w` | `deg` | W orientation |
| `p` | `deg` | P orientation |
| `r` | `deg` | R orientation |
| `configuration` | `CartesianConfiguration` | FANUC configuration stored with the frame |
| `extended_axes` | `tuple` | Must be empty for User Frames and Tool Frames |

Example:

```python
from fanucx import CartesianPosition


frame = CartesianPosition(
    x=100.0,
    y=200.0,
    z=-300.0,
    w=8.0,
    p=0.0,
    r=0.0,
    configuration="N D B, 0, 0, 0",
)
```

## Frame configuration

The FANUC controller stores configuration data together with a frame position. FanucX exposes it through the `CartesianConfiguration` object:

```python
frame = robot.uframe[1]

print(frame.configuration)
print(frame.configuration.value)
```

Example configuration:

```text
N D B, 0, 0, 0
```

The frame transformation is defined by its `X`, `Y`, `Z`, `W`, `P`, and `R` components. The configuration is preserved because it is part of the controller's stored `POSITION` representation.

Applications should normally preserve the configuration returned by the controller when reading and rewriting an existing frame:

```python
frame = robot.uframe[1]

frame.x = 150.0

robot.uframe[1] = frame
```

When creating a new frame, the configuration can be passed as a string:

```python
frame = CartesianPosition(
    x=100.0,
    y=200.0,
    z=-300.0,
    w=8.0,
    p=0.0,
    r=0.0,
    configuration="N D B, 0, 0, 0",
)
```

It can also be passed as a `CartesianConfiguration` object:

```python
from fanucx import (
    CartesianConfiguration,
    CartesianPosition,
)


configuration = CartesianConfiguration("N D B, 0, 0, 0")

frame = CartesianPosition(
    x=100.0,
    y=200.0,
    z=-300.0,
    w=8.0,
    p=0.0,
    r=0.0,
    configuration=configuration,
)
```

The Python `CartesianConfiguration` class stores the configuration string. The FanucX server validates the configuration before writing the frame to the controller.

An invalid configuration is rejected and raises `RobotOperationError`.

## Extended axes

User Frames and Tool Frames cannot contain extended-axis values.

The following frame is valid:

```python
frame = CartesianPosition(
    x=100.0,
    y=200.0,
    z=-300.0,
    w=8.0,
    p=0.0,
    r=0.0,
    configuration="N D B, 0, 0, 0",
)
```

The following frame is rejected:

```python
frame = CartesianPosition(
    x=100.0,
    y=200.0,
    z=-300.0,
    w=8.0,
    p=0.0,
    r=0.0,
    configuration="N D B, 0, 0, 0",
    extended_axes=(1000.0,),
)

robot.uframe[1] = frame
# ValueError
```

---

# User Frames

User Frames are available through:

```python
robot.uframe
```

A User Frame defines a Cartesian coordinate system used to express programmed positions relative to a workpiece, fixture, machine, or another application reference.

## Reading a User Frame

For Motion Group 1, use indexed access:

```python
frame = robot.uframe[1]
```

The returned value is a `CartesianPosition`:

```python
print(frame.x)
print(frame.y)
print(frame.z)
print(frame.w)
print(frame.p)
print(frame.r)
print(frame.configuration.value)
```

To specify the motion group explicitly:

```python
frame = robot.uframe.get(1, group=1)
```

For another motion group:

```python
frame = robot.uframe.get(1, group=2)
```

## Writing a User Frame

Create a frame:

```python
from fanucx import CartesianPosition


frame = CartesianPosition(
    x=100.0,
    y=200.0,
    z=-300.0,
    w=8.0,
    p=0.0,
    r=0.0,
    configuration="N D B, 0, 0, 0",
)
```

Write it to User Frame 1 in Motion Group 1:

```python
robot.uframe[1] = frame
```

The explicit equivalent is:

```python
robot.uframe.set(1, frame, group=1)
```

For another motion group:

```python
robot.uframe.set(1, frame, group=2)
```

The value must be a `CartesianPosition`:

```python
robot.uframe[1] = "FRAME"
# TypeError
```

## User Frame comments

Read a comment for Motion Group 1:

```python
comment = robot.uframe.comment[1]
```

Write a comment:

```python
robot.uframe.comment[1] = "ASSEMBLY FRAME"
```

Clear a comment:

```python
robot.uframe.comment[1] = ""
```

For another motion group:

```python
comment = robot.uframe.comment.get(1, group=2)

robot.uframe.comment.set(1, "ASSEMBLY FRAME", group=2)
```

User Frame comments:

- must be `str`,
- cannot exceed 29 characters,
- cannot contain `|`, because `|` is reserved by the FanucX protocol.

```python
robot.uframe.comment[1] = 123
# TypeError
```

```python
robot.uframe.comment[1] = "FRAME|COMMENT"
# ValueError
```

## Active User Frame

Read the active User Frame for Motion Group 1:

```python
frame_number = robot.uframe.active
```

Set the active User Frame:

```python
robot.uframe.active = 1
```

The property is equivalent to:

```python
frame_number = robot.uframe.get_active(group=1)

robot.uframe.set_active(1, group=1)
```

For another motion group:

```python
frame_number = robot.uframe.get_active(group=2)

robot.uframe.set_active(1, group=2)
```

An active User Frame value of `0` selects World Frame:

```python
robot.uframe.active = 0
```

A positive value selects the corresponding configured User Frame:

```python
robot.uframe.active = 2
# Selects UFRAME[2] for Motion Group 1
```

Changing the active User Frame takes effect immediately.

---

# Tool Frames

Tool Frames are available through:

```python
robot.utool
```

A Tool Frame defines the position and orientation of the tool coordinate system relative to the robot flange.

## Reading a Tool Frame

For Motion Group 1, use indexed access:

```python
frame = robot.utool[1]
```

The returned value is a `CartesianPosition`:

```python
print(frame.x)
print(frame.y)
print(frame.z)
print(frame.w)
print(frame.p)
print(frame.r)
print(frame.configuration.value)
```

To specify the motion group explicitly:

```python
frame = robot.utool.get(1, group=1)
```

For another motion group:

```python
frame = robot.utool.get(1, group=2)
```

## Writing a Tool Frame

Create a Tool Frame:

```python
from fanucx import CartesianPosition


tool = CartesianPosition(
    x=25.0,
    y=55.0,
    z=888.0,
    w=150.0,
    p=44.0,
    r=0.22,
    configuration="N U T, 0, 0, 0",
)
```

Write it to Tool Frame 1 in Motion Group 1:

```python
robot.utool[1] = tool
```

The explicit equivalent is:

```python
robot.utool.set(1, tool, group=1)
```

For another motion group:

```python
robot.utool.set(1, tool, group=2)
```

The value must be a `CartesianPosition`:

```python
robot.utool[1] = 123
# TypeError
```

## Tool Frame comments

Read a comment for Motion Group 1:

```python
comment = robot.utool.comment[1]
```

Write a comment:

```python
robot.utool.comment[1] = "GRIPPER TCP"
```

Clear a comment:

```python
robot.utool.comment[1] = ""
```

For another motion group:

```python
comment = robot.utool.comment.get(1, group=2)

robot.utool.comment.set(1, "GRIPPER TCP", group=2)
```

Tool Frame comments:

- must be `str`,
- cannot exceed 29 characters,
- cannot contain `|`.

```python
robot.utool.comment[1] = 123
# TypeError
```

```python
robot.utool.comment[1] = "TOOL|COMMENT"
# ValueError
```

## Active Tool Frame

Read the active Tool Frame for Motion Group 1:

```python
frame_number = robot.utool.active
```

Set the active Tool Frame:

```python
robot.utool.active = 1
```

The property is equivalent to:

```python
frame_number = robot.utool.get_active(group=1)

robot.utool.set_active(1, group=1)
```

For another motion group:

```python
frame_number = robot.utool.get_active(group=2)

robot.utool.set_active(1, group=2)
```

An active Tool Frame value of `0` selects Tool Frame 0, whose origin is located at the robot flange:

```python
robot.utool.active = 0
```

A positive value selects the corresponding configured Tool Frame:

```python
robot.utool.active = 2
# Selects UTOOL[2] for Motion Group 1
```

Changing the active Tool Frame takes effect immediately.

---

# Payload Schedules

Payload Schedules are available through:

```python
robot.payload
```

A payload configuration contains:

- payload mass,
- center-of-gravity coordinates,
- moments of inertia around the X, Y, and Z axes.

## Payload model

Payload values are represented using the `Payload` class:

```python
from fanucx import Payload
```

Create a payload:

```python
payload = Payload(
    mass=15.5,
    center_x=5.0,
    center_y=4.0,
    center_z=15.0,
    inertia_x=5.0,
    inertia_y=0.2,
    inertia_z=8.66,
)
```

A `Payload` contains:

| Attribute | Unit | Description |
|---|---|---|
| `mass` | `kg` | Payload mass |
| `center_x` | `cm` | X coordinate of the payload center of gravity |
| `center_y` | `cm` | Y coordinate of the payload center of gravity |
| `center_z` | `cm` | Z coordinate of the payload center of gravity |
| `inertia_x` | `kgf·cm·s²` | Payload moment of inertia around the X axis |
| `inertia_y` | `kgf·cm·s²` | Payload moment of inertia around the Y axis |
| `inertia_z` | `kgf·cm·s²` | Payload moment of inertia around the Z axis |

All payload fields:

- must be `int` or `float`,
- cannot be `bool`.

The following values must be greater than or equal to zero:

- `mass`,
- `inertia_x`,
- `inertia_y`,
- `inertia_z`.

Center-of-gravity coordinates may be negative.

```python
Payload(
    mass=-1.0,
    center_x=0.0,
    center_y=0.0,
    center_z=0.0,
    inertia_x=0.0,
    inertia_y=0.0,
    inertia_z=0.0,
)
# ValueError
```

```python
Payload(
    mass=True,
    center_x=0.0,
    center_y=0.0,
    center_z=0.0,
    inertia_x=0.0,
    inertia_y=0.0,
    inertia_z=0.0,
)
# TypeError
```

## Payload inertia conversion

The dedicated FANUC Payload configuration screen displays inertia values in:

```text
kgf·cm·s²
```

The controller variables used to store payload inertia use an internal scale factor of `980`.

This scale factor is based on the relation between kilogram-force and kilogram-mass.

The controller uses the approximate acceleration due to gravity:

```text
g ≈ 9.8 m/s²
```

Together with the required conversion between meters and centimeters, this produces the internal scale factor:

```text
9.8 × 100 = 980
```

The inertia conversion used by the controller is therefore:

```text
controller_value = displayed_value × 980
```

The internal value is numerically equivalent to an approximate moment of inertia expressed in `kg·cm²`.

For example:

```text
5.00 × 980 = 4900.0
```

Therefore, an inertia value displayed on the FANUC Payload configuration screen as:

```text
5.00 kgf·cm·s²
```

is stored internally by the controller as:

```text
4900.0
```

FanucX applies this conversion automatically.

When reading a payload:

```text
Python value = controller value / 980
```

When writing a payload:

```text
Controller value = Python value × 980
```

As a result, the values exposed by the Python API match the values displayed on the FANUC Payload configuration screen:

```python
payload = robot.payload[1]

print(payload.inertia_x)
# 5.0
```

Applications must not apply the internal scale factor manually:

```python
payload = Payload(
    mass=15.5,
    center_x=5.0,
    center_y=4.0,
    center_z=15.0,
    inertia_x=5.0,
    inertia_y=0.2,
    inertia_z=8.66,
)
```

The example above uses the inertia values exactly as displayed on the controller.

### Standard gravity and the FANUC scale factor

The standard acceleration of gravity is defined as:

```text
g₀ = 9.80665 m/s²
```

Using the exact standard gravity would produce the conversion factor:

```text
980.665
```

The FANUC controller representation observed by FanucX uses the simplified factor:

```text
980
```

Because the controller stores and transfers payload values using floating-point values, a value displayed as:

```text
8.66
```

may be returned by Python as:

```python
8.659999801020408
```

This is a normal floating-point representation effect.

Use formatting when displaying payload values:

```python
print(f"{payload.inertia_z:.2f}")
# 8.66
```

Use a tolerance when comparing payload values:

```python
TOLERANCE = 0.0001

values_match = (
    abs(payload.inertia_z - 8.66)
    < TOLERANCE
)
```

## Reading a Payload Schedule

For Motion Group 1, use indexed access:

```python
payload = robot.payload[1]
```

The returned value is a `Payload`:

```python
print(payload.mass)

print(payload.center_x)
print(payload.center_y)
print(payload.center_z)

print(payload.inertia_x)
print(payload.inertia_y)
print(payload.inertia_z)
```

To specify the motion group explicitly:

```python
payload = robot.payload.get(1, group=1)
```

For another motion group:

```python
payload = robot.payload.get(1, group=2)
```

## Writing a Payload Schedule

Create a payload:

```python
from fanucx import Payload


payload = Payload(
    mass=5.5,
    center_x=10.0,
    center_y=-20.0,
    center_z=150.0,
    inertia_x=0.1,
    inertia_y=0.2,
    inertia_z=0.3,
)
```

Write it to Payload Schedule 1 in Motion Group 1:

```python
robot.payload[1] = payload
```

The explicit equivalent is:

```python
robot.payload.set(1, payload, group=1)
```

For another motion group:

```python
robot.payload.set(1, payload, group=2)
```

The value must be a `Payload` object:

```python
robot.payload[1] = 123
# TypeError
```

The payload mass must not exceed the maximum payload supported by the selected robot motion group.

The maximum permitted mass is validated by the FANUC controller. If the mass exceeds the configured maximum, the operation is rejected and FanucX raises `RobotOperationError`.

### Non-transactional payload writes

A payload schedule contains seven fields that are written sequentially.

The payload write operation is not transactional. If a later field cannot be written, fields written earlier in the sequence may remain modified.

Applications should:

- validate payload data before writing,
- read the payload after writing to confirm all values,
- preserve the original payload if restoration may be required,
- avoid interrupting the connection during a payload write,
- avoid concurrent modification by TP programs, KAREL programs, PLC logic, or another client.

Example verification:

```python
robot.payload[1] = payload

received_payload = robot.payload[1]

print(received_payload.mass)
print(received_payload.center_x)
print(received_payload.inertia_x)
```

## Payload comments

Read a comment for Motion Group 1:

```python
comment = robot.payload.comment[1]
```

Write a comment:

```python
robot.payload.comment[1] = "GRIPPER WITH PART"
```

Clear a comment:

```python
robot.payload.comment[1] = ""
```

For another motion group:

```python
comment = robot.payload.comment.get(1, group=2)

robot.payload.comment.set(1, "GRIPPER WITH PART", group=2)
```

Payload comments:

- must be `str`,
- cannot exceed 17 characters,
- cannot contain `|`.

```python
robot.payload.comment[1] = 123
# TypeError
```

```python
robot.payload.comment[1] = "PAYLOAD|COMMENT"
# ValueError
```

An uninitialized payload comment is returned as an empty string:

```python
comment = robot.payload.comment[2]

print(comment)
# ""
```

## Active Payload

Read the active Payload Schedule for Motion Group 1:

```python
payload_number = robot.payload.active
```

Set the active Payload Schedule:

```python
robot.payload.active = 1
```

The property is equivalent to:

```python
payload_number = robot.payload.get_active(group=1)

robot.payload.set_active(1, group=1)
```

For another motion group:

```python
payload_number = robot.payload.get_active(group=2)

robot.payload.set_active(1, group=2)
```

Payload number `0` selects the controller default payload for the robot model:

```python
robot.payload.active = 0
```

The default payload uses:

- the maximum payload mass defined for the robot,
- center-of-gravity coordinates equal to zero,
- inertia values equal to zero.

Payload `0` is a special controller selection. It is not a normal editable Payload Schedule and cannot be accessed through:

```python
robot.payload[0]
# ValueError
```

A positive value selects the corresponding configured Payload Schedule:

```python
robot.payload.active = 2
# Selects Payload Schedule 2 for Motion Group 1
```

Changing the active payload takes effect immediately.

---

# Special number 0

The value `0` is valid only when selecting an active motion configuration.

| Resource | Meaning of active value `0` |
|---|---|
| User Frame | World Frame |
| Tool Frame | Tool origin at the robot flange |
| Payload | Default payload for the robot model |

Examples:

```python
robot.uframe.active = 0
robot.utool.active = 0
robot.payload.active = 0
```

Configured User Frames, Tool Frames, and Payload Schedules use positive numbers.

The following operations are invalid:

```python
robot.uframe[0]
# ValueError
```

```python
robot.utool[0]
# ValueError
```

```python
robot.payload[0]
# ValueError
```

The special value `0` does not represent a normal editable configuration slot.

---

# Working with multiple motion groups

Indexed access always uses Motion Group 1:

```python
user_frame = robot.uframe[1]
tool_frame = robot.utool[1]
payload = robot.payload[1]
```

Indexed comments also use Motion Group 1:

```python
user_frame_comment = robot.uframe.comment[1]
tool_frame_comment = robot.utool.comment[1]
payload_comment = robot.payload.comment[1]
```

The `.active` properties use Motion Group 1:

```python
active_user_frame = robot.uframe.active
active_tool_frame = robot.utool.active
active_payload = robot.payload.active
```

Use explicit methods for another motion group:

```python
user_frame = robot.uframe.get(1, group=2)

tool_frame = robot.utool.get(1, group=2)

payload = robot.payload.get(1, group=2)
```

Write values for another motion group:

```python
robot.uframe.set(1, user_frame, group=2)

robot.utool.set(1, tool_frame, group=2)

robot.payload.set(1, payload, group=2)
```

Read active selections:

```python
active_user_frame = robot.uframe.get_active(group=2)

active_tool_frame = robot.utool.get_active(group=2)

active_payload = robot.payload.get_active(group=2)
```

Set active selections:

```python
robot.uframe.set_active(1, group=2)

robot.utool.set_active(1, group=2)

robot.payload.set_active(1, group=2)
```

The active configuration is stored independently for each motion group.

---

# Controller range validation

FanucX validates locally that regular frame numbers, payload numbers, and motion group numbers:

- are `int`,
- are not `bool`,
- are greater than zero.

The Python library does not maintain fixed maximum numbers for User Frames, Tool Frames, or Payload Schedules.

The FANUC controller determines the available ranges from its configuration:

- the maximum User Frame number,
- the maximum Tool Frame number,
- the maximum Payload Schedule number,
- the available motion groups,
- the maximum permitted payload mass for each motion group.

A positive number can therefore pass local Python validation and still be rejected by the controller.

If a frame number, payload number, group number, or payload mass exceeds the configured controller limit, the FanucX server returns:

```text
FX_STATUS_INVALID_ARGUMENT = -3
```

The Python client exposes this failure as `RobotOperationError`:

```text
Robot operation failed. Error code: -3
```

---

# Validation

## Regular configuration numbers

User Frame numbers, Tool Frame numbers, Payload Schedule numbers, and motion group numbers:

- must be `int`,
- cannot be `bool`,
- must be greater than zero.

```python
robot.uframe.get(0)
# ValueError
```

```python
robot.utool.get("1")
# TypeError
```

```python
robot.payload.get(True)
# TypeError
```

```python
robot.uframe.get(1, group=0)
# ValueError
```

## Active configuration numbers

Active User Frame, Tool Frame, and Payload numbers:

- must be `int`,
- cannot be `bool`,
- must be greater than or equal to zero.

```python
robot.uframe.active = -1
# ValueError
```

```python
robot.utool.active = 1.0
# TypeError
```

```python
robot.payload.active = True
# TypeError
```

## Frame values

A User Frame or Tool Frame:

- must be a `CartesianPosition`,
- must not contain extended axes,
- must contain Cartesian values accepted by the controller,
- must contain valid FANUC configuration data.

## Payload values

A `Payload`:

- contains seven numeric fields,
- accepts `int` and `float`,
- rejects `bool`,
- requires non-negative mass,
- requires non-negative inertia values,
- allows negative center-of-gravity coordinates.

The controller additionally validates the payload mass against the maximum payload supported by the selected motion group.

## Comment validation

| Resource | Maximum length |
|---|---:|
| User Frame comment | 29 characters |
| Tool Frame comment | 29 characters |
| Payload comment | 17 characters |

Comments:

- must be `str`,
- may be empty,
- cannot contain the reserved `|` separator.

---

# Response validation

User Frame and Tool Frame responses must contain exactly seven fields:

```text
X;Y;Z;W;P;R;CONFIGURATION
```

The six Cartesian components must be numeric.

Payload responses must contain exactly seven numeric fields:

```text
MASS;CENTER_X;CENTER_Y;CENTER_Z;INERTIA_X;INERTIA_Y;INERTIA_Z
```

Active User Frame, Tool Frame, and Payload responses must contain a non-negative integer.

FanucX raises `RobotProtocolError` if:

- a frame response does not contain exactly seven fields,
- a frame Cartesian component is not numeric,
- a payload response does not contain exactly seven fields,
- a payload field is not numeric,
- a payload response contains invalid negative values,
- an active configuration response is not an integer,
- an active configuration response contains a negative value.

---

# Exceptions

Motion configuration operations can raise the following public exceptions:

| Exception | Typical cause |
|---|---|
| `RobotNotConnectedError` | Request made without an active robot connection |
| `RobotConnectionError` | Connection setup failed |
| `RobotCommunicationError` | Communication failed after connecting |
| `RobotOperationError` | Controller rejected a frame, payload, group number, configuration, mass, or active selection |
| `RobotProtocolError` | Controller returned an invalid frame, payload, or active-number response |
| `TypeError` | Invalid index, group, object, field, comment, or active-number type |
| `ValueError` | Invalid local range, negative payload data, extended axes, comment length, or reserved separator |

Example:

```python
from fanucx import RobotOperationError


try:
    frame = robot.uframe[999999]
except RobotOperationError as error:
    print(error)
```

The exact available range depends on the selected controller and its configuration.

---

# Safety and data ownership

Changing a User Frame, Tool Frame, Payload Schedule, or active motion configuration can immediately affect robot motion.

Changing an active frame or payload does not itself command movement, but subsequent motion instructions may use the new configuration.

An incorrect configuration can cause:

- unexpected Cartesian motion,
- incorrect TCP positioning,
- unexpected orientation,
- incorrect path interpretation,
- excessive acceleration or deceleration,
- inaccurate collision detection,
- incorrect payload compensation,
- mechanical overload,
- damage to tooling, workpieces, fixtures, or the robot.

Before writing motion configuration data:

- confirm the selected motion group,
- confirm the selected frame or payload number,
- verify the coordinate values and units,
- verify the Tool Center Point,
- verify the payload mass and center of gravity,
- verify payload inertia values,
- preserve the existing configuration before overwriting it,
- avoid modifying data used by production programs,
- define clear ownership between FanucX, TP programs, KAREL programs, PLC logic, and other external systems,
- avoid concurrent writes from multiple systems,
- do not change active frames or payloads during robot motion,
- do not change active motion configuration while a production program or FanucX motion request is using it,
- test changes in RoboGuide or at reduced speed with a verified clear workspace.

Motion configuration operations are not safety-rated.

FanucX does not replace:

- DCS,
- collision detection,
- payload verification,
- controller safety logic,
- guarding,
- machine risk assessment,
- safe commissioning procedures.

A successful write response confirms that the controller accepted the operation. It does not prove that the resulting configuration is mechanically correct or safe.

---

# Quick reference

```python
from fanucx import (
    CartesianPosition,
    Payload,
)


# User Frame, Motion Group 1
user_frame = robot.uframe[1]
robot.uframe[1] = user_frame

user_frame_comment = robot.uframe.comment[1]
robot.uframe.comment[1] = "ASSEMBLY FRAME"

active_user_frame = robot.uframe.active
robot.uframe.active = 1

# World Frame
robot.uframe.active = 0


# Tool Frame, Motion Group 1
tool_frame = robot.utool[1]
robot.utool[1] = tool_frame

tool_frame_comment = robot.utool.comment[1]
robot.utool.comment[1] = "GRIPPER TCP"

active_tool_frame = robot.utool.active
robot.utool.active = 1

# Tool origin at the robot flange
robot.utool.active = 0


# Payload Schedule, Motion Group 1
payload = robot.payload[1]
robot.payload[1] = payload

payload_comment = robot.payload.comment[1]
robot.payload.comment[1] = "PART PAYLOAD"

active_payload = robot.payload.active
robot.payload.active = 1

# Default payload for the robot model
robot.payload.active = 0


# User Frame in another Motion Group
user_frame = robot.uframe.get(1, group=2)

robot.uframe.set(1, user_frame, group=2)


# Tool Frame in another Motion Group
tool_frame = robot.utool.get(1, group=2)

robot.utool.set(1, tool_frame, group=2)


# Payload Schedule in another Motion Group
payload = robot.payload.get(1, group=2)

robot.payload.set(1, payload, group=2)


# Create a User Frame
user_frame = CartesianPosition(
    x=100.0,
    y=200.0,
    z=-300.0,
    w=8.0,
    p=0.0,
    r=0.0,
    configuration="N D B, 0, 0, 0",
)

robot.uframe[1] = user_frame


# Create a Tool Frame
tool_frame = CartesianPosition(
    x=25.0,
    y=55.0,
    z=888.0,
    w=150.0,
    p=44.0,
    r=0.22,
    configuration="N U T, 0, 0, 0",
)

robot.utool[1] = tool_frame


# Create a Payload Schedule
payload = Payload(
    mass=15.5,
    center_x=5.0,
    center_y=4.0,
    center_z=15.0,
    inertia_x=5.0,
    inertia_y=0.2,
    inertia_z=8.66,
)

robot.payload[1] = payload
```
