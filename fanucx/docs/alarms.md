# Alarms

FanucX provides read-only access to the FANUC controller alarm history.

Alarm operations are available through:

```python
robot.alarms
```

FanucX can:

- read the most recent alarm history entry,
- read the oldest available alarm history entry,
- read the first alarm after a specified sequence number,
- retrieve multiple alarm history entries in chronological order.

FanucX does not provide operations for clearing alarms, resetting faults, or modifying the controller alarm history.

## Overview

| Operation | FanucX API | Result |
|---|---|---|
| Read the latest alarm | `robot.alarms.latest()` | `Alarm` |
| Read the oldest available alarm | `robot.alarms.oldest()` | `Alarm` |
| Read the first alarm after a sequence number | `robot.alarms.next_after(sequence_number)` | `Alarm` |
| Read multiple history entries | `robot.alarms.history(limit=20)` | `list[Alarm]` |

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
    alarm = robot.alarms.latest()
    print(alarm.message)
finally:
    robot.disconnect()
```

Alarm operations require an active connection. Calling an operation before `connect()` or after `disconnect()` raises `RobotNotConnectedError`.

---

# Alarm model

Each alarm history entry is returned as an `Alarm` object.

```python
from fanucx import Alarm
```

An `Alarm` contains the following fields:

| Field | Python type | Description |
|---|---|---|
| `sequence_number` | `int` | Sequence number identifying the alarm history entry |
| `code` | `int` | FANUC alarm code |
| `message` | `str` | Alarm message |
| `cause_code` | `int` | Associated cause code |
| `cause_message` | `str` | Associated cause description |
| `timestamp` | `str` | Timestamp returned by the controller |
| `severity` | `AlarmSeverity` | Alarm severity |
| `program` | `str` | Program associated with the alarm entry |

## FANUC alarm information

The `code`, `cause_code`, and `severity` values are reported by the FANUC controller. FanucX preserves these values and exposes them through the `Alarm` object.

The meaning of an alarm code or cause code depends on the controller software version, installed options, and alarm category.

For detailed descriptions, causes, and recommended recovery procedures, consult the FANUC documentation applicable to the controller, including:

- the FANUC Alarm Code List,
- the relevant controller maintenance manual,
- option-specific manuals when the alarm belongs to an installed software or hardware option.

FanucX does not maintain its own alarm-code or cause-code catalog.

Example:

```python
alarm = robot.alarms.latest()

print(alarm.sequence_number)
print(alarm.code)
print(alarm.message)
print(alarm.cause_code)
print(alarm.cause_message)
print(alarm.timestamp)
print(alarm.severity)
print(alarm.program)
```

## Immutable alarm entries

`Alarm` is an immutable dataclass.

Its fields can be read but cannot be modified:

```python
alarm = robot.alarms.latest()
alarm.message = "NEW MESSAGE"
# FrozenInstanceError
```

This prevents an alarm object from being changed after it has been parsed from the controller response.

An `Alarm` object represents a history entry returned by the controller. Modifying a Python object would not modify the actual controller alarm history.

---

# Alarm severity

Alarm severity is represented by the `AlarmSeverity` enumeration:

```python
from fanucx import AlarmSeverity
```

The following severity values are supported:

| Numeric value | Enum member | Meaning |
|---:|---|---|
| `0` | `AlarmSeverity.WARNING` | Warning |
| `1` | `AlarmSeverity.PAUSE` | Pause |
| `2` | `AlarmSeverity.ABORT` | Abort |

The severity value is supplied by the FANUC controller and converted to the corresponding `AlarmSeverity` member by FanucX.

The severity classification should be interpreted together with the alarm code, cause code, controller state, and the applicable FANUC documentation.

Example:

```python
alarm = robot.alarms.latest()

if alarm.severity is AlarmSeverity.WARNING:
    print("Warning alarm")

elif alarm.severity is AlarmSeverity.PAUSE:
    print("Pause alarm")

elif alarm.severity is AlarmSeverity.ABORT:
    print("Abort alarm")
```

`AlarmSeverity` inherits from `IntEnum`. The numeric value is available through:

```python
severity_value = alarm.severity.value
print(severity_value)
```

The severity name is available through:

```python
severity_name = alarm.severity.name
print(severity_name)
```

If the controller returns a severity value other than `0`, `1`, or `2`, FanucX raises `RobotProtocolError`.

---

# Reading the latest alarm

Use `latest()` to read the most recent available alarm history entry:

```python
alarm = robot.alarms.latest()
```

Example:

```python
alarm = robot.alarms.latest()

print(f"Sequence: {alarm.sequence_number}")
print(f"Code: {alarm.code}")
print(f"Message: {alarm.message}")
print(f"Timestamp: {alarm.timestamp}")
print(f"Severity: {alarm.severity.name}")
print(f"Program: {alarm.program}")
```

The method returns an `Alarm` object.

If the controller cannot return a latest alarm entry, the request is rejected and FanucX raises `RobotOperationError`.

---

# Reading the oldest alarm

Use `oldest()` to read the oldest alarm entry currently available in the controller history:

```python
alarm = robot.alarms.oldest()
```

Example:

```python
alarm = robot.alarms.oldest()

print(alarm.sequence_number)
print(alarm.message)
```

`oldest()` is equivalent to:

```python
alarm = robot.alarms.next_after(0)
```

The method requests the first available alarm after sequence number `0`.

If no alarm history entry is available, FanucX raises `RobotOperationError`.

---

# Reading the next alarm

Use `next_after()` to read the first available alarm after a specified sequence number:

```python
alarm = robot.alarms.next_after(100)
```

The method returns the first alarm history entry whose sequence comes after the supplied sequence number.

This operation can be used to traverse the alarm history:

```python
first_alarm = robot.alarms.next_after(0)

second_alarm = robot.alarms.next_after(
    first_alarm.sequence_number,
)

third_alarm = robot.alarms.next_after(
    second_alarm.sequence_number,
)
```

## Sequence number validation

The sequence number:

- must be `int`,
- cannot be `bool`,
- must be greater than or equal to zero.

```python
robot.alarms.next_after("100")
# TypeError
```

```python
robot.alarms.next_after(True)
# TypeError
```

```python
robot.alarms.next_after(-1)
# ValueError
```

Sequence number `0` is valid and requests the first available alarm history entry:

```python
alarm = robot.alarms.next_after(0)
```

If no later alarm entry is available, FanucX raises `RobotOperationError`.

---

# Reading alarm history

Use `history()` to retrieve multiple alarm history entries:

```python
alarms = robot.alarms.history()
```

The default limit is `20`:

```python
alarms = robot.alarms.history(limit=20)
```

The method returns a Python list containing `Alarm` objects:

```python
for alarm in alarms:
    print(
        alarm.sequence_number,
        alarm.code,
        alarm.message,
    )
```

Entries are returned from oldest to newest according to their sequence numbers.

## History limit

The `limit` argument specifies the maximum number of entries to return:

```python
alarms = robot.alarms.history(limit=100)
```

The limit:

- must be `int`,
- cannot be `bool`,
- must be greater than zero.

```python
robot.alarms.history(limit="20")
# TypeError
```

```python
robot.alarms.history(limit=True)
# TypeError
```

```python
robot.alarms.history(limit=0)
# ValueError
```

```python
robot.alarms.history(limit=-1)
# ValueError
```

The limit is the maximum number of entries requested, not a guarantee that the returned list will contain that many entries.

If fewer entries are available, `history()` returns the entries retrieved before the end of the available history is reached.

```python
alarms = robot.alarms.history(limit=100)

print(len(alarms))
# May be less than 100
```

If no alarm entry is available, `history()` returns an empty list:

```python
alarms = robot.alarms.history()

if not alarms:
    print("No alarm history entries returned")
```

## History termination behavior

`history()` starts with sequence number `0` and repeatedly requests the next alarm:

```text
0 -> first available alarm -> next alarm -> next alarm
```

Retrieval stops when:

- the requested limit is reached, or
- the controller rejects the request for another entry.

A `RobotOperationError` raised while requesting the next entry is treated as the end of the available alarm history. The entries retrieved before that point are returned.

## Sequence progression validation

Each alarm returned during history retrieval must have a sequence number greater than the previous sequence number.

If the sequence number does not advance, FanucX raises `RobotProtocolError`:

```text
Alarm history sequence did not advance.
```

This validation prevents an invalid controller response from causing repeated entries or an endless history traversal.

---

# Filtering alarm history

FanucX returns alarm entries without applying local filters. Standard Python operations can be used to filter the returned list.

## Filter by severity

```python
from fanucx import AlarmSeverity


alarms = robot.alarms.history(limit=100)

abort_alarms = [
    alarm
    for alarm in alarms
    if alarm.severity is AlarmSeverity.ABORT
]
```

## Filter by alarm code

```python
alarms = robot.alarms.history(limit=100)

matching_alarms = [
    alarm
    for alarm in alarms
    if alarm.code == 123
]
```

## Filter by program

```python
alarms = robot.alarms.history(limit=100)

program_alarms = [
    alarm
    for alarm in alarms
    if alarm.program == "MY_PROGRAM"
]
```

## Search alarm messages

```python
alarms = robot.alarms.history(limit=100)

servo_alarms = [
    alarm
    for alarm in alarms
    if "SERVO" in alarm.message.upper()
]
```

Filtering occurs after the history entries have been retrieved. The `limit` applies to the number of entries requested from FanucX, not to the number of entries remaining after filtering.

---

# Timestamp

The `timestamp` field is returned as a Python `str`:

```python
alarm = robot.alarms.latest()
print(alarm.timestamp)
```

FanucX preserves the timestamp text returned by the controller. It does not convert the timestamp to a Python `datetime` object.

Applications that require sorting, timezone handling, date calculations, or a specific output format must parse the timestamp according to the format returned by the controller.

Alarm history traversal uses `sequence_number`, not the timestamp text.

---

# Program and cause information

An alarm may include additional diagnostic information:

```python
alarm = robot.alarms.latest()

print(alarm.cause_code)
print(alarm.cause_message)
print(alarm.program)
```

The `code`, `cause_code`, `cause_message`, `severity`, and `program` fields contain diagnostic information reported by the FANUC controller.

The availability and meaning of these fields depend on the alarm type, controller software version, installed options, and information available in the controller alarm history.

Applications should not assume that every alarm has a non-empty cause message or program name.

Use the alarm code and cause code with the applicable FANUC alarm and maintenance documentation to determine the documented cause and recovery procedure.

The primary identifier for alarm history traversal is `sequence_number`.

---

# Response validation

FanucX expects every alarm response to contain exactly eight fields:

```text
SEQUENCE_NUMBER
CODE
MESSAGE
CAUSE_CODE
CAUSE_MESSAGE
TIMESTAMP
SEVERITY
PROGRAM
```

The following fields must contain valid integers:

- sequence number,
- alarm code,
- cause code,
- severity.

The sequence number must be greater than zero.

The severity must be one of:

```text
0
1
2
```

FanucX raises `RobotProtocolError` if:

- the response does not contain exactly eight fields,
- an expected integer field cannot be converted to `int`,
- the sequence number is zero or negative,
- the severity value is unsupported,
- history traversal returns a sequence number that does not advance.

The internal field separator used by the alarm response is not part of the public API and should not be parsed directly by application code.

---

# Exceptions

Alarm operations can raise the following public exceptions:

| Exception | Typical cause |
|---|---|
| `RobotNotConnectedError` | Request made without an active robot connection |
| `RobotConnectionError` | Connection setup failed |
| `RobotCommunicationError` | Communication failed after connecting |
| `RobotOperationError` | Controller could not return the requested alarm entry or no later entry is available |
| `RobotProtocolError` | Invalid alarm response, unsupported severity, invalid sequence number, or non-advancing history sequence |
| `TypeError` | Invalid `sequence_number` or `limit` type |
| `ValueError` | Negative sequence number or non-positive history limit |

Example:

```python
from fanucx import RobotOperationError


try:
    alarm = robot.alarms.latest()
except RobotOperationError as error:
    print(error)
```

When using `next_after()` directly, the caller must handle `RobotOperationError` if no later entry is available:

```python
from fanucx import RobotOperationError


try:
    alarm = robot.alarms.next_after(100)
except RobotOperationError:
    print("No later alarm entry is available")
```

The `history()` method handles `RobotOperationError` internally and returns the entries retrieved before the operation was rejected.

---

# Safety and diagnostics

Alarm history is diagnostic information. Reading alarm history does not acknowledge, clear, reset, or correct an active controller fault.

FanucX alarm access must not be treated as a replacement for:

- the FANUC teach pendant alarm display,
- FANUC alarm documentation,
- controller maintenance procedures,
- machine-specific recovery instructions,
- DCS and safety-system diagnostics,
- inspection by qualified maintenance personnel.

An alarm history entry may describe a previous event rather than the controller's current operating state.

Before acting on an alarm:

- confirm whether the alarm is currently active,
- inspect the controller and teach pendant state,
- consult the applicable FANUC alarm documentation,
- follow the machine manufacturer's recovery procedure,
- confirm that the cause of the alarm has been removed,
- do not reset or restart equipment unless the work area is safe.

The `severity` field indicates the category stored in the alarm history entry. It does not independently determine whether it is safe to continue operation.

---

# Quick reference

```python
from fanucx import AlarmSeverity


# Most recent alarm
latest_alarm = robot.alarms.latest()

print(latest_alarm.sequence_number)
print(latest_alarm.code)
print(latest_alarm.message)
print(latest_alarm.cause_code)
print(latest_alarm.cause_message)
print(latest_alarm.timestamp)
print(latest_alarm.severity)
print(latest_alarm.program)

# Oldest available alarm
oldest_alarm = robot.alarms.oldest()

# First alarm after a sequence number
next_alarm = robot.alarms.next_after(
    latest_alarm.sequence_number,
)

# Up to 20 entries, from oldest to newest
alarms = robot.alarms.history()

# Up to 100 entries
alarms = robot.alarms.history(limit=100)

# Filter Abort alarms
abort_alarms = [
    alarm
    for alarm in alarms
    if alarm.severity is AlarmSeverity.ABORT
]

# Display history
for alarm in alarms:
    print(
        alarm.sequence_number,
        alarm.timestamp,
        alarm.severity.name,
        alarm.code,
        alarm.message,
    )
```
