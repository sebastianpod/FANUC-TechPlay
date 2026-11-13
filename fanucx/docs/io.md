# I/O

FanucX provides Pythonic, indexed access to FANUC flags and I/O ports.

I/O values and comments are exposed through the `Robot` instance using:

- `robot.f`
- `robot.di`
- `robot.do`
- `robot.gi`
- `robot.go`
- `robot.ai`
- `robot.ao`
- `robot.ri`
- `robot.ro`
- `robot.ui`
- `robot.uo`
- `robot.si`
- `robot.so`

## Overview

| FANUC resource | FanucX API | Value type | Value access | Comment access |
|---|---|---:|---|---|
| Flag `F[n]` | `robot.f[n]` | `bool` | Read/write | Read/write |
| Digital Input `DI[n]` | `robot.di[n]` | `bool` | Read-only | Read/write |
| Digital Output `DO[n]` | `robot.do[n]` | `bool` | Read/write | Read/write |
| Group Input `GI[n]` | `robot.gi[n]` | `int` | Read-only | Read/write |
| Group Output `GO[n]` | `robot.go[n]` | `int` | Read/write | Read/write |
| Analog Input `AI[n]` | `robot.ai[n]` | `int` | Read-only | Read/write |
| Analog Output `AO[n]` | `robot.ao[n]` | `int` | Read/write | Read/write |
| Robot Input `RI[n]` | `robot.ri[n]` | `bool` | Read-only | Read/write |
| Robot Output `RO[n]` | `robot.ro[n]` | `bool` | Read/write | Read/write |
| User Input `UI[n]` | `robot.ui[n]` | `bool` | Read-only | Read-only |
| User Output `UO[n]` | `robot.uo[n]` | `bool` | Read-only | Read-only |
| SOP Input `SI[n]` | `robot.si[n]` | `bool` | Read-only | Read-only |
| SOP Output `SO[n]` | `robot.so[n]` | `bool` | Read-only | Read-only |

Boolean I/O values are represented using Python `bool` values:

```python
True
False
```

Integer I/O values are represented using Python `int` values.

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
    print(robot.di[1])
    print(robot.do[1])
finally:
    robot.disconnect()
```

I/O operations require an active connection. Calling an I/O operation before `connect()` or after `disconnect()` raises `RobotNotConnectedError`.

---

# Flags

FANUC flags are available through:

```python
robot.f
```

Flags support reading and writing Boolean values.

## Reading a Flag

```python
value = robot.f[1]
print(value)
```

The returned value is a Python `bool`.

The FanucX server represents flag values using `0` and `1`. FanucX converts the protocol value to:

| Protocol value | Python value |
|---:|---|
| `0` | `False` |
| `1` | `True` |

Any other response value raises `RobotProtocolError`.

## Writing a Flag

```python
robot.f[1] = True
robot.f[2] = False
```

Flag values must be `bool`.

```python
robot.f[1] = 1
# TypeError
```

Although `bool` is a subclass of `int` in Python, integer values are not accepted. Use `True` or `False` explicitly.

## Flag comments

Read a comment:

```python
comment = robot.f.comment[1]
print(comment)
```

Write a comment:

```python
robot.f.comment[1] = "CYCLE ENABLE"
```

Clear a comment:

```python
robot.f.comment[1] = ""
```

Flag comments:

- must be `str`,
- cannot exceed 24 characters,
- cannot contain `|`, because `|` is reserved by the FanucX protocol.

```python
robot.f.comment[1] = "VALUE|WITH|SEPARATOR"
# ValueError
```

---

# Digital I/O

Digital I/O values are represented using Python `bool` values.

Digital Inputs are read-only. Digital Outputs support reading and writing.

## Digital Inputs

Digital Inputs are available through:

```python
robot.di
```

### Reading a Digital Input

```python
value = robot.di[1]

if value:
    print("DI[1] is ON")
else:
    print("DI[1] is OFF")
```

The returned value is a Python `bool`.

Digital Input values cannot be written through FanucX:

```python
robot.di[1] = True
# TypeError: object does not support item assignment
```

### Digital Input comments

Read a comment:

```python
comment = robot.di.comment[1]
```

Write a comment:

```python
robot.di.comment[1] = "PART PRESENT"
```

Clear a comment:

```python
robot.di.comment[1] = ""
```

Digital Input comments:

- must be `str`,
- cannot exceed 24 characters,
- cannot contain `|`.

## Digital Outputs

Digital Outputs are available through:

```python
robot.do
```

### Reading a Digital Output

```python
value = robot.do[1]
print(value)
```

The returned value is a Python `bool`.

### Writing a Digital Output

```python
robot.do[1] = True
robot.do[2] = False
```

Digital Output values must be `bool`.

```python
robot.do[1] = 1
# TypeError
```

```python
robot.do[1] = "ON"
# TypeError
```

### Digital Output comments

Read a comment:

```python
comment = robot.do.comment[1]
```

Write a comment:

```python
robot.do.comment[1] = "GRIPPER OPEN"
```

Clear a comment:

```python
robot.do.comment[1] = ""
```

Digital Output comments:

- must be `str`,
- cannot exceed 24 characters,
- cannot contain `|`.

---

# Group I/O

Group I/O combines multiple digital signals into an integer value.

Group Inputs are read-only. Group Outputs support reading and writing.

The valid value range of a configured Group I/O port depends on its bit width in the FANUC controller configuration.

## Group Inputs

Group Inputs are available through:

```python
robot.gi
```

### Reading a Group Input

```python
value = robot.gi[1]
print(value)
```

The returned value is a Python `int`.

```python
if robot.gi[1] == 5:
    print("Recipe 5 selected")
```

Group Input values cannot be written through FanucX:

```python
robot.gi[1] = 5
# TypeError: object does not support item assignment
```

### Group Input comments

Read a comment:

```python
comment = robot.gi.comment[1]
```

Write a comment:

```python
robot.gi.comment[1] = "RECIPE NUMBER"
```

Clear a comment:

```python
robot.gi.comment[1] = ""
```

Group Input comments:

- must be `str`,
- cannot exceed 24 characters,
- cannot contain `|`.

## Group Outputs

Group Outputs are available through:

```python
robot.go
```

### Reading a Group Output

```python
value = robot.go[1]
print(value)
```

The returned value is a Python `int`.

### Writing a Group Output

```python
robot.go[1] = 5
```

Group Output values:

- must be `int`,
- cannot be `bool`,
- must be greater than or equal to zero,
- must fit within the configured bit width of the selected Group Output.

```python
robot.go[1] = -1
# ValueError
```

```python
robot.go[1] = 5.0
# TypeError
```

```python
robot.go[1] = True
# TypeError
```

The FanucX Python client validates that the value is a non-negative integer before sending the request.

Validation against the configured Group Output bit width is performed on the FANUC controller by the FanucX server implemented in KAREL.

If `GO[1]` is configured as an 8-bit Group Output:

```python
robot.go[1] = 255
# Accepted
```

```python
robot.go[1] = 256
# RobotOperationError
```

If the value does not fit within the configured Group Output width, the operation is rejected and FanucX raises `RobotOperationError`.

The operation may also raise `RobotOperationError` if the selected Group Output is not correctly assigned in the controller I/O configuration.

### Group Output comments

Read a comment:

```python
comment = robot.go.comment[1]
```

Write a comment:

```python
robot.go.comment[1] = "STATUS CODE"
```

Clear a comment:

```python
robot.go.comment[1] = ""
```

Group Output comments:

- must be `str`,
- cannot exceed 24 characters,
- cannot contain `|`.

---

# Analog I/O

Analog I/O values are represented using Python `int` values.

Analog Inputs are read-only. Analog Outputs support reading and writing.

## Analog Inputs

Analog Inputs are available through:

```python
robot.ai
```

### Reading an Analog Input

```python
value = robot.ai[1]
print(value)
```

The returned value is a Python `int`.

FanucX returns the integer value reported by the controller. The engineering interpretation of that value depends on the FANUC I/O configuration, hardware, scaling, and field device.

Analog Input values cannot be written through FanucX:

```python
robot.ai[1] = 1000
# TypeError: object does not support item assignment
```

### Analog Input comments

Read a comment:

```python
comment = robot.ai.comment[1]
```

Write a comment:

```python
robot.ai.comment[1] = "PRESSURE"
```

Clear a comment:

```python
robot.ai.comment[1] = ""
```

Analog Input comments:

- must be `str`,
- cannot exceed 24 characters,
- cannot contain `|`.

## Analog Outputs

Analog Outputs are available through:

```python
robot.ao
```

### Reading an Analog Output

```python
value = robot.ao[1]
print(value)
```

The returned value is a Python `int`.

### Writing an Analog Output

```python
robot.ao[1] = 32768
```

Analog Output values:

- must be `int`,
- cannot be `bool`,
- must be between `0` and `65535`, inclusive.

```python
robot.ao[1] = -1
# ValueError
```

```python
robot.ao[1] = 65536
# ValueError
```

```python
robot.ao[1] = 100.0
# TypeError
```

```python
robot.ao[1] = True
# TypeError
```

The numeric value written through FanucX is the controller value. Its physical meaning depends on the configured analog hardware, signal type, scaling, and connected device.

Do not assume that `0` through `65535` directly represents volts, milliamps, pressure, speed, or another engineering unit unless the corresponding scaling is defined in the controller and field-device configuration.

### Analog Output comments

Read a comment:

```python
comment = robot.ao.comment[1]
```

Write a comment:

```python
robot.ao.comment[1] = "SPEED REFERENCE"
```

Clear a comment:

```python
robot.ao.comment[1] = ""
```

Analog Output comments:

- must be `str`,
- cannot exceed 24 characters,
- cannot contain `|`.

---

# Robot I/O

Robot I/O provides Boolean ports commonly associated with robot peripheral and end-effector signals.

Robot Inputs are read-only. Robot Outputs support reading and writing.

## Robot Inputs

Robot Inputs are available through:

```python
robot.ri
```

### Reading a Robot Input

```python
value = robot.ri[1]
print(value)
```

The returned value is a Python `bool`.

Robot Input values cannot be written through FanucX:

```python
robot.ri[1] = True
# TypeError: object does not support item assignment
```

### Robot Input comments

Read a comment:

```python
comment = robot.ri.comment[1]
```

Write a comment:

```python
robot.ri.comment[1] = "GRIPPER CLOSED"
```

Clear a comment:

```python
robot.ri.comment[1] = ""
```

Robot Input comments:

- must be `str`,
- cannot exceed 24 characters,
- cannot contain `|`.

## Robot Outputs

Robot Outputs are available through:

```python
robot.ro
```

### Reading a Robot Output

```python
value = robot.ro[1]
print(value)
```

The returned value is a Python `bool`.

### Writing a Robot Output

```python
robot.ro[1] = True
robot.ro[2] = False
```

Robot Output values must be `bool`.

```python
robot.ro[1] = 1
# TypeError
```

### Robot Output comments

Read a comment:

```python
comment = robot.ro.comment[1]
```

Write a comment:

```python
robot.ro.comment[1] = "OPEN GRIPPER"
```

Clear a comment:

```python
robot.ro.comment[1] = ""
```

Robot Output comments:

- must be `str`,
- cannot exceed 24 characters,
- cannot contain `|`.

---

# UOP and SOP

FanucX provides read-only access to UOP and SOP signals:

| FANUC resource | FanucX API | Value access | Comment access |
|---|---|---|---|
| User Input `UI[n]` | `robot.ui[n]` | Read-only | Read-only |
| User Output `UO[n]` | `robot.uo[n]` | Read-only | Read-only |
| SOP Input `SI[n]` | `robot.si[n]` | Read-only | Read-only |
| SOP Output `SO[n]` | `robot.so[n]` | Read-only | Read-only |

FanucX intentionally does not provide write access to these signals.

## User Inputs

Read a User Input:

```python
value = robot.ui[1]
print(value)
```

Read its comment:

```python
comment = robot.ui.comment[1]
print(comment)
```

The returned value is a Python `bool`.

User Input values and comments cannot be written through FanucX:

```python
robot.ui[1] = True
# TypeError: object does not support item assignment
```

```python
robot.ui.comment[1] = "NEW COMMENT"
# TypeError: object does not support item assignment
```

## User Outputs

Read a User Output:

```python
value = robot.uo[1]
print(value)
```

Read its comment:

```python
comment = robot.uo.comment[1]
print(comment)
```

The returned value is a Python `bool`.

User Output values and comments cannot be written through FanucX.

## SOP Inputs

Read an SOP Input:

```python
value = robot.si[1]
print(value)
```

Read its comment:

```python
comment = robot.si.comment[1]
print(comment)
```

The returned value is a Python `bool`.

SOP Input values and comments cannot be written through FanucX.

## SOP Outputs

Read an SOP Output:

```python
value = robot.so[1]
print(value)
```

Read its comment:

```python
comment = robot.so.comment[1]
print(comment)
```

The returned value is a Python `bool`.

SOP Output values and comments cannot be written through FanucX.

---

# Comments

Writable I/O comments use the following common rules:

- the value must be `str`,
- the value cannot exceed 24 characters,
- the value cannot contain `|`,
- an empty string clears the comment.

Example:

```python
robot.do.comment[1] = "GRIPPER OPEN"
```

Clear the comment:

```python
robot.do.comment[1] = ""
```

Invalid type:

```python
robot.do.comment[1] = 123
# TypeError
```

Comment longer than 24 characters:

```python
robot.do.comment[1] = "THIS COMMENT IS TOO LONG FOR THE PORT"
# ValueError
```

Reserved protocol separator:

```python
robot.do.comment[1] = "OPEN|CLOSE"
# ValueError
```

The common writable-comment rules apply to:

- flags,
- Digital Inputs and Outputs,
- Group Inputs and Outputs,
- Analog Inputs and Outputs,
- Robot Inputs and Outputs.

Comments for `UI`, `UO`, `SI`, and `SO` are read-only.

---

# Validation

FanucX validates I/O indices before sending a request to the controller.

An I/O index:

- must be an `int`,
- cannot be a `bool`,
- must be greater than zero.

```python
robot.di[0]
# ValueError
```

```python
robot.do["1"]
# TypeError
```

```python
robot.f[True]
# TypeError
```

The same index validation applies to comment access:

```python
robot.do.comment[0]
# ValueError
```

Local validation does not know how many ports of each type are configured on the controller.

A positive index can therefore pass local validation and still be rejected by the controller.

## Value validation summary

| Resource | Accepted write type | Accepted range |
|---|---|---|
| `robot.f[n]` | `bool` | `False` or `True` |
| `robot.do[n]` | `bool` | `False` or `True` |
| `robot.go[n]` | `int`, excluding `bool` | `0` or greater |
| `robot.ao[n]` | `int`, excluding `bool` | `0-65535` |
| `robot.ro[n]` | `bool` | `False` or `True` |

The following resources are read-only:

```text
DI
GI
AI
RI
UI
UO
SI
SO
```

---

# Protocol response validation

Boolean resources must return either:

```text
0
```

or:

```text
1
```

FanucX converts these protocol values to Python `False` and `True`.

An unexpected Boolean response raises `RobotProtocolError`.

Integer resources must return a value that can be converted to a Python `int`.

An invalid Group I/O or Analog I/O response raises `RobotProtocolError`.

---

# Exceptions

I/O operations can raise the following public exceptions:

| Exception | Typical cause |
|---|---|
| `RobotNotConnectedError` | Request made without an active robot connection |
| `RobotConnectionError` | Connection setup failed |
| `RobotCommunicationError` | Communication failed after connecting |
| `RobotOperationError` | Controller rejected an otherwise valid request |
| `RobotProtocolError` | Controller returned an unexpected Boolean or integer response |
| `TypeError` | Invalid index, value, or comment type |
| `ValueError` | Invalid index, value range, comment length, or reserved separator |

Example:

```python
from fanucx import RobotOperationError


try:
    value = robot.di[999999]
except RobotOperationError as error:
    print(error)
```

Writing to an object that intentionally does not implement `__setitem__`, such as `robot.di`, `robot.ui`, or `robot.ui.comment`, raises Python's standard `TypeError`.

---

# Safety and data ownership

Writing an output can immediately affect connected equipment or controller logic.

Depending on the cell configuration, an output may control or request operation of:

- grippers,
- clamps,
- valves,
- conveyors,
- weld equipment,
- process equipment,
- external axes,
- PLC sequences,
- machine interlocks.

Before writing an output:

- confirm the selected I/O type and index,
- verify the controller I/O configuration,
- verify the physical or logical destination of the signal,
- define clear ownership between FanucX, TP programs, KAREL programs, PLC logic, and other external systems,
- avoid writing outputs that are controlled by production programs or PLC logic,
- avoid conflicting writes from multiple tasks or systems,
- confirm that changing the signal cannot create unexpected equipment motion,
- test changes in RoboGuide or with controlled commissioning procedures where applicable.

Reading or writing I/O through FanucX is not safety-rated.

FanucX must not be used to bypass safety circuits, DCS, guarding, emergency-stop circuits, enabling devices, safety PLC logic, or other safety-rated controller functions.

A successful write response confirms that the controller accepted the operation. It does not prove that the connected field device reached the requested state.

Use an appropriate input or device-status signal when confirmation of physical operation is required.

---

# Quick reference

```python
# Flags
flag = robot.f[1]
robot.f[1] = True
robot.f.comment[1] = "CYCLE ENABLE"

# Digital I/O
digital_input = robot.di[1]
digital_output = robot.do[1]
robot.do[1] = True

robot.di.comment[1] = "PART PRESENT"
robot.do.comment[1] = "GRIPPER OPEN"

# Group I/O
group_input = robot.gi[1]
group_output = robot.go[1]
robot.go[1] = 5

robot.gi.comment[1] = "RECIPE NUMBER"
robot.go.comment[1] = "STATUS CODE"

# Analog I/O
analog_input = robot.ai[1]
analog_output = robot.ao[1]
robot.ao[1] = 32768

robot.ai.comment[1] = "PRESSURE"
robot.ao.comment[1] = "SPEED REFERENCE"

# Robot I/O
robot_input = robot.ri[1]
robot_output = robot.ro[1]
robot.ro[1] = True

robot.ri.comment[1] = "GRIPPER CLOSED"
robot.ro.comment[1] = "OPEN GRIPPER"

# Read-only UOP and SOP values
user_input = robot.ui[1]
user_output = robot.uo[1]
sop_input = robot.si[1]
sop_output = robot.so[1]

# Read-only UOP and SOP comments
user_input_comment = robot.ui.comment[1]
user_output_comment = robot.uo.comment[1]
sop_input_comment = robot.si.comment[1]
sop_output_comment = robot.so.comment[1]
```
