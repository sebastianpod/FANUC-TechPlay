# Variables

FanucX provides typed read and write access to FANUC KAREL program variables and controller system variables.

Variable operations are available through:

```python
robot.variables
```

FanucX supports the following variable types:

| FANUC variable type | Read method | Write method | Python type |
|---|---|---|---|
| Boolean | `get_boolean()` | `set_boolean()` | `bool` |
| Integer | `get_integer()` | `set_integer()` | `int` |
| Real | `get_real()` | `set_real()` | `float` |
| String | `get_string()` | `set_string()` | `str` |

Every operation requires:

- the name of the KAREL program containing the variable,
- the variable path,
- the new value for write operations.

Use `*SYSTEM*` as the program name to access controller system variables.

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
    value = robot.variables.get_integer(
        "MY_PROGRAM",
        "part_count",
    )

    print(value)
finally:
    robot.disconnect()
```

Variable operations require an active connection. Calling an operation before `connect()` or after `disconnect()` raises `RobotNotConnectedError`.

---

# Variable paths

A variable is identified by a program name and variable path:

```python
value = robot.variables.get_integer(
    "MY_PROGRAM",
    "part_count",
)
```

The program name identifies the KAREL program containing the variable.

The variable path identifies the variable within that program.

Variable paths can contain array indices and nested structure fields:

```python
value = robot.variables.get_integer(
    "MY_PROGRAM",
    "parts[1].count",
)
```

The exact path must match a variable that is available through the FANUC variable interface.

## Program name validation

The program name:

- must be `str`,
- cannot be empty,
- cannot contain `|`, because `|` is reserved by the FanucX protocol.

```python
robot.variables.get_integer(
    123,
    "part_count",
)
# TypeError
```

```python
robot.variables.get_integer(
    "",
    "part_count",
)
# ValueError
```

```python
robot.variables.get_integer(
    "MY|PROGRAM",
    "part_count",
)
# ValueError
```

## Variable name validation

The variable name or path:

- must be `str`,
- cannot be empty,
- cannot contain `|`.

```python
robot.variables.get_integer(
    "MY_PROGRAM",
    123,
)
# TypeError
```

```python
robot.variables.get_integer(
    "MY_PROGRAM",
    "",
)
# ValueError
```

```python
robot.variables.get_integer(
    "MY_PROGRAM",
    "data|count",
)
# ValueError
```

---

# Boolean variables

Boolean variables are read using `get_boolean()` and written using `set_boolean()`.

## Reading a Boolean variable

```python
value = robot.variables.get_boolean(
    "MY_PROGRAM",
    "cycle_enabled",
)

print(value)
```

The returned value is a Python `bool`.

FanucX converts Boolean protocol values as follows:

| Protocol value | Python value |
|---:|---|
| `0` | `False` |
| `1` | `True` |

An unexpected response value raises `RobotProtocolError`.

## Writing a Boolean variable

```python
robot.variables.set_boolean(
    "MY_PROGRAM",
    "cycle_enabled",
    True,
)
```

Set the variable to `False`:

```python
robot.variables.set_boolean(
    "MY_PROGRAM",
    "cycle_enabled",
    False,
)
```

The value must be `bool`.

```python
robot.variables.set_boolean(
    "MY_PROGRAM",
    "cycle_enabled",
    1,
)
# TypeError
```

Although `bool` is a subclass of `int` in Python, integer values are not accepted. Use `True` or `False` explicitly.

The target variable must have a compatible Boolean type and must permit write access. Otherwise, the operation is rejected and FanucX raises `RobotOperationError`.

---

# Integer variables

Integer variables are read using `get_integer()` and written using `set_integer()`.

## Reading an Integer variable

```python
value = robot.variables.get_integer(
    "MY_PROGRAM",
    "part_count",
)

print(value)
```

The returned value is a Python `int`.

If the controller response cannot be converted to `int`, FanucX raises `RobotProtocolError`.

## Writing an Integer variable

```python
robot.variables.set_integer(
    "MY_PROGRAM",
    "part_count",
    100,
)
```

Negative values are supported:

```python
robot.variables.set_integer(
    "MY_PROGRAM",
    "offset",
    -25,
)
```

The value:

- must be `int`,
- cannot be `bool`.

```python
robot.variables.set_integer(
    "MY_PROGRAM",
    "part_count",
    100.0,
)
# TypeError
```

```python
robot.variables.set_integer(
    "MY_PROGRAM",
    "part_count",
    True,
)
# TypeError
```

FanucX does not apply a local numeric range limit to Integer values. The value must fit within the range accepted by the target FANUC Integer variable.

If the value is outside the supported range, the target variable has an incompatible type, or the variable does not permit write access, the operation is rejected and FanucX raises `RobotOperationError`.

---

# Real variables

Real variables are read using `get_real()` and written using `set_real()`.

## Reading a Real variable

```python
value = robot.variables.get_real(
    "MY_PROGRAM",
    "measured_distance",
)

print(value)
```

The returned value is a Python `float`.

Real values may be returned by the controller in scientific notation. FanucX converts the response to `float`.

For example, a controller response such as:

```text
1.250000E+02
```

is returned as:

```python
125.0
```

If the controller response cannot be converted to `float`, FanucX raises `RobotProtocolError`.

## Writing a Real variable

```python
robot.variables.set_real(
    "MY_PROGRAM",
    "measured_distance",
    125.5,
)
```

Integer values are also accepted:

```python
robot.variables.set_real(
    "MY_PROGRAM",
    "measured_distance",
    125,
)
```

The value:

- must be `int` or `float`,
- cannot be `bool`.

```python
robot.variables.set_real(
    "MY_PROGRAM",
    "measured_distance",
    "125.5",
)
# TypeError
```

```python
robot.variables.set_real(
    "MY_PROGRAM",
    "measured_distance",
    True,
)
# TypeError
```

The target variable must have a compatible Real type and must permit write access. Values must also be representable by the FANUC Real variable interface.

If the value is rejected, the target variable has an incompatible type, or the variable does not permit write access, FanucX raises `RobotOperationError`.

---

# String variables

String variables are read using `get_string()` and written using `set_string()`.

## Reading a String variable

```python
value = robot.variables.get_string(
    "MY_PROGRAM",
    "part_name",
)

print(value)
```

The returned value is a Python `str`.

The current FanucX protocol cannot return String variable values containing `|`.

If a target String variable contains the reserved protocol separator, the read operation is rejected and FanucX raises `RobotOperationError`.

## Writing a String variable

```python
robot.variables.set_string(
    "MY_PROGRAM",
    "part_name",
    "FANUCX",
)
```

An empty string is accepted:

```python
robot.variables.set_string(
    "MY_PROGRAM",
    "part_name",
    "",
)
```

This assigns an empty value to the target String variable.

The value:

- must be `str`,
- cannot contain `|`.

```python
robot.variables.set_string(
    "MY_PROGRAM",
    "part_name",
    123,
)
# TypeError
```

```python
robot.variables.set_string(
    "MY_PROGRAM",
    "part_name",
    "PART|NAME",
)
# ValueError
```

FanucX does not define a local maximum String length in the Python API. The accepted length depends on the target FANUC String variable and the limits of the controller variable interface.

If the value is too long for the target variable, the target variable has an incompatible type, or the variable does not permit write access, the operation is rejected and FanucX raises `RobotOperationError`.

---

# System variables

Use `*SYSTEM*` as the program name to access controller system variables:

```python
value = robot.variables.get_integer(
    "*SYSTEM*",
    "$SOME_VARIABLE",
)
```

Nested system-variable fields and array indices can be included in the variable path:

```python
value = robot.variables.get_integer(
    "*SYSTEM*",
    "$SOME_STRUCTURE[1].$FIELD",
)
```

Use the method matching the actual FANUC data type:

```python
boolean_value = robot.variables.get_boolean(
    "*SYSTEM*",
    "$BOOLEAN_VARIABLE",
)

integer_value = robot.variables.get_integer(
    "*SYSTEM*",
    "$INTEGER_VARIABLE",
)

real_value = robot.variables.get_real(
    "*SYSTEM*",
    "$REAL_VARIABLE",
)

string_value = robot.variables.get_string(
    "*SYSTEM*",
    "$STRING_VARIABLE",
)
```

Some system variables are read-only or protected by the controller.

A variable that can be read successfully is not necessarily writable. If the controller does not permit the requested write, FanucX raises `RobotOperationError`.

Changing a writable system variable can immediately affect controller behavior. Do not modify system variables without understanding their FANUC-defined purpose and operational consequences.

---

# Arrays and nested structures

A variable path can refer to an array element:

```python
value = robot.variables.get_integer(
    "MY_PROGRAM",
    "part_counts[1]",
)
```

A path can also refer to a field within a structure:

```python
value = robot.variables.get_real(
    "MY_PROGRAM",
    "process_data.temperature",
)
```

Array indices and structure fields can be combined:

```python
value = robot.variables.get_integer(
    "MY_PROGRAM",
    "stations[2].part_count",
)
```

FanucX passes the variable path to the controller as a single string. Python does not parse or validate array indices, structure fields, variable existence, or the target variable type.

An invalid path is rejected by the controller and raises `RobotOperationError`.

---

# Type matching

The selected FanucX method must match the actual type of the target FANUC variable.

| Target type | Required methods |
|---|---|
| Boolean | `get_boolean()` and `set_boolean()` |
| Integer | `get_integer()` and `set_integer()` |
| Real | `get_real()` and `set_real()` |
| String | `get_string()` and `set_string()` |

For example, do not use `get_integer()` for a Real variable:

```python
value = robot.variables.get_integer(
    "MY_PROGRAM",
    "real_value",
)
# RobotOperationError
```

FanucX does not automatically discover the target variable type or convert between incompatible FANUC variable types.

An Integer value can be passed to `set_real()` because the Python API accepts both `int` and `float`. The target FANUC variable must still be a Real variable.

---

# Validation

FanucX validates the program name and variable path before sending a request.

## Program and variable validation

| Argument | Requirements |
|---|---|
| `program` | Must be a non-empty `str` and cannot contain the reserved protocol separator |
| `variable` | Must be a non-empty `str` and cannot contain the reserved protocol separator |

The reserved FanucX protocol separator is `|`.

## Value validation

| Method | Accepted Python value |
|---|---|
| `set_boolean()` | `bool` |
| `set_integer()` | `int`, excluding `bool` |
| `set_real()` | `int` or `float`, excluding `bool` |
| `set_string()` | `str` without `|` |

FanucX performs Python type validation locally.

The controller determines:

- whether the program exists,
- whether the variable exists,
- whether the variable path is valid,
- whether the selected method matches the variable type,
- whether the value fits the target variable,
- whether the variable permits read or write access.

A controller-side rejection raises `RobotOperationError`.

---

# Protocol response validation

Boolean variable responses must contain:

```text
0
```

or:

```text
1
```

Any other Boolean response raises `RobotProtocolError`.

Integer variable responses must be convertible to Python `int`.

An invalid Integer response raises `RobotProtocolError`.

Real variable responses must be convertible to Python `float`.

An invalid Real response raises `RobotProtocolError`.

String variable responses are returned as Python `str`. String values containing the reserved protocol separator `|` cannot be returned by the current FanucX protocol.

---

# Exceptions

Variable operations can raise the following public exceptions:

| Exception | Typical cause |
|---|---|
| `RobotNotConnectedError` | Request made without an active robot connection |
| `RobotConnectionError` | Connection setup failed |
| `RobotCommunicationError` | Communication failed after connecting |
| `RobotOperationError` | Program or variable not found, invalid variable path, type mismatch, write-protected variable, unsupported value, or controller rejection |
| `RobotProtocolError` | Controller returned an unexpected Boolean, Integer, or Real response |
| `TypeError` | Invalid program, variable, or value type |
| `ValueError` | Empty program or variable name, or use of the reserved `|` separator |

Example:

```python
from fanucx import RobotOperationError


try:
    value = robot.variables.get_integer(
        "MY_PROGRAM",
        "missing_variable",
    )
except RobotOperationError as error:
    print(error)
```

The exact controller error depends on the variable path, variable type, program state, access permissions, and controller configuration.

---

# Safety and data ownership

Writing a variable can immediately affect a running KAREL program, controller logic, robot behavior, or production process.

Before writing a variable:

- confirm the program name,
- confirm the complete variable path,
- confirm the target FANUC variable type,
- confirm that the variable permits write access,
- understand how the program or controller uses the variable,
- avoid changing variables owned by running programs unless external writes are part of their design,
- define clear ownership between FanucX, KAREL programs, TP programs, PLC logic, and other external systems,
- avoid concurrent writes from multiple tasks or systems,
- back up important controller data and program variables,
- use additional caution when modifying system variables through `*SYSTEM*`.

Reading or writing variables through FanucX is not safety-rated.

FanucX must not be used to bypass DCS, safety circuits, guarding, emergency-stop circuits, enabling devices, safety PLC logic, or other safety-rated controller functions.

A successful write confirms that the controller accepted the variable assignment. It does not confirm that a program consumed the value or completed the requested operation.

---

# Quick reference

```python
# Boolean variable
enabled = robot.variables.get_boolean(
    "MY_PROGRAM",
    "cycle_enabled",
)

robot.variables.set_boolean(
    "MY_PROGRAM",
    "cycle_enabled",
    True,
)

# Integer variable
part_count = robot.variables.get_integer(
    "MY_PROGRAM",
    "part_count",
)

robot.variables.set_integer(
    "MY_PROGRAM",
    "part_count",
    100,
)

# Real variable
distance = robot.variables.get_real(
    "MY_PROGRAM",
    "measured_distance",
)

robot.variables.set_real(
    "MY_PROGRAM",
    "measured_distance",
    125.5,
)

# String variable
part_name = robot.variables.get_string(
    "MY_PROGRAM",
    "part_name",
)

robot.variables.set_string(
    "MY_PROGRAM",
    "part_name",
    "FANUCX",
)

# Array element
station_count = robot.variables.get_integer(
    "MY_PROGRAM",
    "station_counts[1]",
)

# Nested structure field
temperature = robot.variables.get_real(
    "MY_PROGRAM",
    "process_data.temperature",
)

# System variable
system_value = robot.variables.get_integer(
    "*SYSTEM*",
    "$INTEGER_VARIABLE",
)
```
