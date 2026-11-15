# Variables

FanucX provides typed, indexed read and write access to FANUC KAREL program variables and controller variables.

Variable operations are available through:

```python
robot.variables
```

FanucX supports the following variable types:

| FANUC variable type | FanucX API | Python type |
|---|---|---|
| Boolean | `robot.variables.boolean[program, variable]` | `bool` |
| Integer | `robot.variables.integer[program, variable]` | `int` |
| Real | `robot.variables.real[program, variable]` | `float` |
| String | `robot.variables.string[program, variable]` | `str` |

Every operation requires:

- a KAREL program name or another access path supported by the FANUC variable interface,
- the variable path,
- the new value for write operations.

Reading uses indexed access:

```python
value = robot.variables.integer["MY_PROGRAM", "part_count"]
```

Writing uses indexed assignment:

```python
robot.variables.integer["MY_PROGRAM", "part_count"] = 100
```

Controller system variables are commonly accessed using `*SYSTEM*`. Other special access paths may also be supported by the controller.

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
    value = robot.variables.integer["MY_PROGRAM", "part_count"]

    print(value)
finally:
    robot.disconnect()
```

Variable operations require an active connection. Calling an operation before `connect()` or after `disconnect()` raises `RobotNotConnectedError`.

---

# Variable keys and paths

A variable is identified by a two-element key:

```python
(
    program,
    variable,
)
```

The key is passed using indexed access:

```python
value = robot.variables.integer["MY_PROGRAM", "part_count"]
```

For a KAREL program variable, the first element identifies the program containing the variable.

The first element can also specify another variable access path supported by the FANUC controller.

The second element identifies the variable within the selected program or variable namespace.

## Variable key validation

The variable access key must contain exactly two values:

```python
robot.variables.integer["MY_PROGRAM", "part_count"]
```

Using only one value is invalid:

```python
robot.variables.integer["MY_PROGRAM"]
# TypeError
```

Using more than two values is also invalid:

```python
robot.variables.integer["MY_PROGRAM", "part_count", "extra"]
# ValueError
```

## Program or access path validation

The program name or access path:

- must be `str`,
- cannot be empty,
- cannot contain `|`, because `|` is reserved by the FanucX protocol.

```python
robot.variables.integer[123, "part_count"]
# TypeError
```

```python
robot.variables.integer["",  "part_count"]
# ValueError
```

```python
robot.variables.integer["MY|PROGRAM", "part_count"]
# ValueError
```

## Variable path validation

The variable name or path:

- must be `str`,
- cannot be empty,
- cannot contain `|`.

```python
robot.variables.integer["MY_PROGRAM", 123]
# TypeError
```

```python
robot.variables.integer["MY_PROGRAM", ""]
# ValueError
```

```python
robot.variables.integer["MY_PROGRAM", "data|count"]
# ValueError
```

Variable paths can contain array indices and nested structure fields:

```python
value = robot.variables.integer["MY_PROGRAM", "parts[1].count"]
```

The exact path must match a variable available through the FANUC variable interface.

---

# Boolean variables

Boolean variables are available through:

```python
robot.variables.boolean
```

## Reading a Boolean variable

```python
value = robot.variables.boolean["MY_PROGRAM", "cycle_enabled"]

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

Set the variable to `True`:

```python
robot.variables.boolean["MY_PROGRAM", "cycle_enabled"] = True
```

Set the variable to `False`:

```python
robot.variables.boolean["MY_PROGRAM", "cycle_enabled"] = False
```

The value must be `bool`.

```python
robot.variables.boolean["MY_PROGRAM", "cycle_enabled"] = 1
# TypeError
```

Although `bool` is a subclass of `int` in Python, integer values are not accepted. Use `True` or `False` explicitly.

The target variable must have a compatible Boolean type and must permit the requested access. Otherwise, the operation is rejected and FanucX raises `RobotOperationError`.

---

# Integer variables

Integer variables are available through:

```python
robot.variables.integer
```

## Reading an Integer variable

```python
value = robot.variables.integer["MY_PROGRAM", "part_count"]

print(value)
```

The returned value is a Python `int`.

If the controller response cannot be converted to `int`, FanucX raises `RobotProtocolError`.

## Writing an Integer variable

```python
robot.variables.integer["MY_PROGRAM", "part_count"] = 100
```

Negative values are supported:

```python
robot.variables.integer["MY_PROGRAM", "offset"] = -25
```

The value:

- must be `int`,
- cannot be `bool`.

```python
robot.variables.integer["MY_PROGRAM", "part_count"] = 100.0
# TypeError
```

```python
robot.variables.integer["MY_PROGRAM", "part_count"] = True
# TypeError
```

FanucX does not apply a local numeric range limit to Integer values. The value must fit within the range accepted by the target FANUC Integer variable.

If the value is outside the supported range, the target variable has an incompatible type, or the variable does not permit write access, the operation is rejected and FanucX raises `RobotOperationError`.

---

# Real variables

Real variables are available through:

```python
robot.variables.real
```

## Reading a Real variable

```python
value = robot.variables.real["MY_PROGRAM", "measured_distance"]

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
robot.variables.real["MY_PROGRAM", "measured_distance"] = 125.5
```

Integer values are also accepted:

```python
robot.variables.real["MY_PROGRAM", "measured_distance"] = 125
```

The value:

- must be `int` or `float`,
- cannot be `bool`.

```python
robot.variables.real["MY_PROGRAM", "measured_distance"] = "125.5"
# TypeError
```

```python
robot.variables.real["MY_PROGRAM", "measured_distance"] = True
# TypeError
```

An Integer value can be passed because the Python API accepts both `int` and `float`. The target FANUC variable must still have a compatible Real type.

If the value is rejected, the target variable has an incompatible type, or the variable does not permit write access, FanucX raises `RobotOperationError`.

---

# String variables

String variables are available through:

```python
robot.variables.string
```

## Reading a String variable

```python
value = robot.variables.string["MY_PROGRAM", "part_name"]

print(value)
```

The returned value is a Python `str`.

The current FanucX protocol cannot return String variable values containing `|`.

If a target String variable contains the reserved protocol separator, the read operation is rejected and FanucX raises `RobotOperationError`.

## Writing a String variable

```python
robot.variables.string["MY_PROGRAM", "part_name"] = "FANUCX"
```

An empty string is accepted:

```python
robot.variables.string["MY_PROGRAM", "part_name"] = ""
```

This assigns an empty value to the target String variable.

The value:

- must be `str`,
- cannot contain `|`.

```python
robot.variables.string["MY_PROGRAM", "part_name"] = 123
# TypeError
```

```python
robot.variables.string["MY_PROGRAM", "part_name"] = "PART|NAME"
# ValueError
```

FanucX does not define a local maximum String length. The accepted length depends on the target FANUC String variable and the limits of the controller variable interface.

If the value is too long for the target variable, the target variable has an incompatible type, or the variable does not permit write access, the operation is rejected and FanucX raises `RobotOperationError`.

---

# Controller variables and special access paths

The first element of the variable key identifies the variable namespace or access path used by the FANUC variable interface.

For variables declared by a KAREL program, pass the KAREL program name:

```python
value = robot.variables.integer["MY_PROGRAM", "part_count"]
```

Controller system variables are commonly accessed using `*SYSTEM*`:

```python
value = robot.variables.integer["*SYSTEM*", "$SOME_VARIABLE"]
```

The variable path can include array indices and nested structure fields:

```python
value = robot.variables.integer["*SYSTEM*", "$SOME_STRUCTURE[1].$FIELD"]
```

`*SYSTEM*` is not the only special access path supported by the FANUC variable interface. Additional access paths may be available depending on:

- the controller software version,
- installed software options,
- the variable type,
- FANUC variable-interface conventions.

FanucX does not maintain its own catalog of available access paths or system variables. The program or access path and variable path are passed to the controller after local validation.

Consult the applicable FANUC documentation for:

- supported access paths,
- variable names,
- data types,
- array ranges,
- structure fields,
- read and write permissions.

For controllers covered by that revision, a relevant reference is:

```text
MARACSSRF03061E [Rev. F]
System Variables [V7.20+]
```

Use the FanucX accessor matching the actual FANUC variable type:

```python
boolean_value = robot.variables.boolean["*SYSTEM*", "$BOOLEAN_VARIABLE"]

integer_value = robot.variables.integer["*SYSTEM*", "$INTEGER_VARIABLE"]

real_value = robot.variables.real["*SYSTEM*", "$REAL_VARIABLE"]

string_value = robot.variables.string["*SYSTEM*", "$STRING_VARIABLE"]
```

The examples above use `*SYSTEM*` because it is the most common access path for controller system variables. The same typed accessors can be used with other access paths supported by the controller.

Some controller variables are:

- read-only,
- protected from external writes,
- unavailable during particular controller states,
- dependent on installed software options.

A variable that can be read successfully is not necessarily writable. If the controller rejects the requested access, FanucX raises `RobotOperationError`.

Changing a writable controller variable can immediately affect controller behavior. Do not modify a controller variable without confirming its purpose, data type, supported values, and write restrictions in the applicable FANUC documentation.

---

# Arrays and nested structures

A variable path can refer to an array element:

```python
value = robot.variables.integer["MY_PROGRAM", "part_counts[1]"]
```

A path can also refer to a field within a structure:

```python
value = robot.variables.real["MY_PROGRAM", "process_data.temperature"]
```

Array indices and structure fields can be combined:

```python
value = robot.variables.integer["MY_PROGRAM", "stations[2].part_count"]
```

FanucX passes the variable path to the controller as a single string.

Python does not parse or validate:

- array indices,
- structure fields,
- variable existence,
- the target FANUC variable type,
- controller access permissions.

An invalid path is rejected by the controller and raises `RobotOperationError`.

---

# Type matching

The selected FanucX accessor must match the actual type of the target FANUC variable.

| Target FANUC type | FanucX accessor |
|---|---|
| Boolean | `robot.variables.boolean` |
| Integer | `robot.variables.integer` |
| Real | `robot.variables.real` |
| String | `robot.variables.string` |

For example, do not use the Integer accessor for a Real variable:

```python
value = robot.variables.integer["MY_PROGRAM", "real_value"]
# RobotOperationError
```

FanucX does not automatically discover the target variable type or convert between incompatible FANUC variable types.

An Integer Python value can be assigned through `robot.variables.real` because that accessor accepts both `int` and `float`. The target FANUC variable must still be a Real variable.

Controller testing confirmed that a type mismatch is rejected by the controller and raised as `RobotOperationError`.

---

# Validation

FanucX validates the variable access key before sending a request.

## Variable key validation

The access key:

- must be a tuple,
- must contain exactly two elements,
- must contain the program or access path as its first element,
- must contain the variable path as its second element.

```python
robot.variables.integer["MY_PROGRAM"]
# TypeError
```

```python
robot.variables.integer["MY_PROGRAM", "part_count", "extra"]
# ValueError
```

## Access path and variable validation

| Key element | Requirements |
|---|---|
| Program or access path | Must be a non-empty `str` and cannot contain the reserved protocol separator |
| Variable path | Must be a non-empty `str` and cannot contain the reserved protocol separator |

The reserved FanucX protocol separator is `|`.

## Value validation

| Accessor | Accepted Python write value |
|---|---|
| `robot.variables.boolean` | `bool` |
| `robot.variables.integer` | `int`, excluding `bool` |
| `robot.variables.real` | `int` or `float`, excluding `bool` |
| `robot.variables.string` | `str` without `|` |

FanucX performs Python type validation locally.

The controller determines:

- whether the specified access path is supported,
- whether the KAREL program or variable namespace exists,
- whether the variable exists,
- whether the variable path is valid,
- whether the selected accessor matches the variable type,
- whether the value fits the target variable,
- whether the variable permits the requested operation.

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

String variable responses are returned as Python `str`.

String values containing the reserved protocol separator `|` cannot be returned by the current FanucX protocol.

---

# Exceptions

Variable operations can raise the following public exceptions:

| Exception | Typical cause |
|---|---|
| `RobotNotConnectedError` | Request made without an active robot connection |
| `RobotConnectionError` | Connection setup failed |
| `RobotCommunicationError` | Communication failed after connecting |
| `RobotOperationError` | Program or variable not found, invalid path, type mismatch, write-protected variable, unsupported value, or controller rejection |
| `RobotProtocolError` | Controller returned an unexpected Boolean, Integer, or Real response |
| `TypeError` | Invalid key type, program type, variable type, or assigned value type |
| `ValueError` | Invalid key length, empty access path, empty variable path, or use of the reserved `|` separator |

Example:

```python
from fanucx import RobotOperationError


try:
    value = robot.variables.integer["MY_PROGRAM", "missing_variable"]
except RobotOperationError as error:
    print(error)
```

The exact controller error depends on:

- the variable path,
- the target variable type,
- the KAREL program state,
- access permissions,
- the controller software and configuration.

---

# Safety and data ownership

Writing a variable can immediately affect a running KAREL program, controller logic, robot behavior, or production process.

Before writing a variable:

- confirm the KAREL program name or controller access path,
- confirm the complete variable path,
- confirm the target FANUC variable type,
- confirm that the variable permits write access,
- understand how the program or controller uses the variable,
- avoid changing variables owned by running programs unless external writes are part of their design,
- define clear ownership between FanucX, KAREL programs, TP programs, PLC logic, and other external systems,
- avoid concurrent writes from multiple tasks or systems,
- back up important controller data and program variables,
- use additional caution when modifying controller variables through `*SYSTEM*` or another special access path.

Reading or writing variables through FanucX is not safety-rated.

FanucX must not be used to bypass:

- DCS,
- safety circuits,
- guarding,
- emergency-stop circuits,
- enabling devices,
- safety PLC logic,
- other safety-rated controller functions.

A successful write confirms that the controller accepted the variable assignment. It does not confirm that a program consumed the value or completed the requested operation.

---

# Quick reference

```python
# Boolean variable
enabled = robot.variables.boolean["MY_PROGRAM", "cycle_enabled"]

robot.variables.boolean["MY_PROGRAM", "cycle_enabled"] = True


# Integer variable
part_count = robot.variables.integer["MY_PROGRAM", "part_count"]

robot.variables.integer["MY_PROGRAM", "part_count"] = 100


# Real variable
distance = robot.variables.real["MY_PROGRAM", "measured_distance"]

robot.variables.real["MY_PROGRAM", "measured_distance"] = 125.5


# String variable
part_name = robot.variables.string["MY_PROGRAM", "part_name"]

robot.variables.string["MY_PROGRAM", "part_name"] = "FANUCX"


# Array element
station_count = robot.variables.integer["MY_PROGRAM", "station_counts[1]"]


# Nested structure field
temperature = robot.variables.real["MY_PROGRAM", "process_data.temperature"]


# Common system-variable access using *SYSTEM*
system_value = robot.variables.integer["*SYSTEM*", "$INTEGER_VARIABLE"]
```
