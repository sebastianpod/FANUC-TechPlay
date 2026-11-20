# FanucX Protocol

FanucX uses a line-based request-response protocol over a TCP connection between the Python client and the FANUC controller server.

This document describes the controller protocol contract. Public Python usage is documented separately in the domain-specific documents under `docs/`.

---

## Transport

The current `FX_SERVER` program uses controller socket slot `S3:`:

```text
S3:
```

FANUC controllers provide socket slots from `S1:` through `S8:`. In the default controller configuration, `S1:` and `S2:` may already be assigned to other services, so `S3:` was selected as the first available slot for FanucX.

A different socket slot can be used, but it must be configured for Socket Messaging on the controller. The selected slot must also be specified in every socket operation in `FX_SERVER`:

```karel
MSG_DISCO('S3:', connection_status)
MSG_CONNECT('S3:', connection_status)
OPEN FILE socket_file('rw', 'S3:')
```

When another slot is selected, replace every `S3:` reference in `FX_SERVER` with the configured slot name.

The server opens the socket in ASCII interactive mode. The Python client encodes requests as UTF-8. Protocol syntax and controller data must therefore use ASCII-compatible characters.

A single `Robot` connection owns one TCP socket. Only one request may be active on that connection at a time. The client must receive the complete response before sending the next request.

Request pipelining is not supported.

### Current message-size limit

The controller request and response buffers use `STRING[254]` values. A complete request must not exceed 254 characters, excluding the terminating line-feed character.

---

## Server handshake

After the TCP connection is established, the controller sends:

```text
FANUCX|1|READY
```

The handshake fields are:

| Field | Meaning |
|---|---|
| `FANUCX` | Protocol identifier |
| `1` | Protocol version |
| `READY` | Server readiness state |

The handshake is sent immediately after the socket is opened. Unlike normal protocol responses, the current handshake is not terminated by a Line Feed (`LF`, ASCII character 10).

The Python client rejects any other handshake with `RobotProtocolError`.

---

## Message framing

Every request is terminated by one line-feed character:

```text
LF
```

Equivalent representations:

```text
\n
CHR(10)
```

Every normal response is also terminated by LF.

---

## Request format

A request contains a decimal command code followed by zero or more command-specific arguments:

```text
COMMAND_CODE[|REQUEST_ARGUMENTS]
```

Examples:

```text
100|1
```

```text
101|1|25
```

```text
720
```

The Python client appends LF before sending the request.

`COMMAND_CODE` must contain unsigned decimal digits only.

---

## Response format

Every normal response contains exactly three top-level fields:

```text
COMMAND_CODE|OPERATION_STATUS|RESPONSE_ARGUMENTS
```

Examples:

```text
100|0|25
```

```text
720|0|1;1;3;1;0
```

```text
721|-3|
```

The response command code must match the request command code. `RESPONSE_ARGUMENTS` may be empty.

---

## Protocol separators

| Separator | Purpose |
|---|---|
| `\|` | Separates top-level request arguments and response fields |
| `;` | Separates structured numeric or position values |
| `^` | Separates fields in alarm responses |
| `,` | Separates FANUC Cartesian configuration components |
| `LF` | Terminates a request or normal response |

The protocol does not provide an escape mechanism for `|`. String values and comments that use `|` as a command separator cannot contain that character.

Alarm text is sanitized by replacing `|` and `^` with spaces before the response is created.

---

## Operation status

`OPERATION_STATUS` reports whether the requested protocol operation completed successfully.

| Value | Name | Meaning |
|---:|---|---|
| `0` | Success | The operation completed successfully |
| `-1` | `FX_STATUS_UNKNOWN_COMMAND` | The command code is syntactically valid but unsupported |
| `-2` | `FX_STATUS_INVALID_REQUEST` | The request does not follow the required protocol format |
| `-3` | `FX_STATUS_INVALID_ARGUMENT` | One or more command arguments are missing or invalid |
| `-4` | `FX_STATUS_INVALID_POSITION_TYPE` | The position representation is unsupported by the requested operation |

Other nonzero values may be returned directly by FANUC controller operations.

The Python client returns `RESPONSE_ARGUMENTS` when `OPERATION_STATUS` is `0`. A nonzero status raises `RobotOperationError`.

A command-specific negative result can still be returned with operation status `0`. For example, command `702` can successfully complete a reachability check and return an unreachable result.

---

## Unknown and invalid commands

An unsupported numeric command retains its command code and returns `FX_STATUS_UNKNOWN_COMMAND`.

Conceptual example:

```text
999|-1|
```

A request with an invalid command-code field uses response command code `0` and returns `FX_STATUS_INVALID_REQUEST`:

```text
0|-2|
```

Reserved command ranges are not treated as implemented commands.

---

# Data formats

## Unsigned integer

Accepted:

```text
0
1
123
```

Rejected:

```text
-1
+1
1.0
 1
1E3
```

## Positive index

Register, port, and Motion Group indexes validated as positive indexes must contain unsigned decimal digits and be greater than zero.

Accepted:

```text
1
100
```

Rejected:

```text
0
-1
ABC
```

## Signed integer

Accepted:

```text
0
123
-123
```

Rejected:

```text
+123
12.3
1E3
```

## Real

Real request values use signed decimal notation.

Accepted:

```text
123
-123
12.34
-12.34
.5
-.5
5.
```

Rejected:

```text
+
-
-.
1.2.3
1E3
1e-3
```

Scientific notation is not supported in Real request arguments.

Some Real responses use fixed decimal notation with six digits after the decimal point. Real variable reads use the controller's scientific-notation conversion format.

## Boolean

Boolean values use:

```text
0 - FALSE or OFF
1 - TRUE or ON
```

## Cartesian position

```text
X;Y;Z;W;P;R;CONFIGURATION[;EXT1;EXT2;EXT3]
```

Extended axes are command-dependent. Position Register operations can support up to three extended axes. Motion and reachability commands do not accept extended axes.

## Joint position

```text
J1;J2;...;Jn
```

Position Register commands support between one and nine axes. Motion commands require exactly six axes.

## Cartesian configuration

The complete format is:

```text
N/F U/D T/B, TURN1, TURN2, TURN3
```

Examples:

```text
N U T, 0, 0, 0
F D B, -1, 0, 1
```

Rules:

- flag 1 is `N` or `F`,
- flag 2 is `U` or `D`,
- flag 3 is `T` or `B`,
- spaces between flags are required,
- exactly three comma-separated turn numbers are required,
- each turn number is one decimal digit, optionally preceded by `-`,
- `+` and multi-digit turn numbers are not accepted by the current validator.

## Empty response arguments

An empty third response field is valid for:

- successful write operations,
- successful motion-start operations,
- successful motion abort,
- comments or strings that are empty.

---

# Command ranges

## Supported ranges

| Range | Domain |
|---:|---|
| `100-199` | Register operations |
| `200-299` | I/O operations |
| `300-399` | Variable operations |
| `500-599` | Alarm and diagnostic operations |
| `600-699` | User Frame, Tool Frame, and Payload operations |
| `700-799` | Robot position and motion operations |

## Reserved ranges

| Range | Reserved domain |
|---:|---|
| `400-499` | Program and task operations |
| `900-999` | Session, protocol-version, and server-diagnostic operations |

Reserved ranges do not imply that any command in the range is implemented.

---

# Register commands

## Numeric Registers

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `100` | Read Numeric Register | `REGISTER_INDEX` | Integer or Real value |
| `101` | Write Numeric Register | `REGISTER_INDEX\|VALUE` | Empty |
| `102` | Read Numeric Register comment | `REGISTER_INDEX` | `COMMENT` |
| `103` | Write Numeric Register comment | `REGISTER_INDEX\|COMMENT` | Empty |

A Numeric Register index must be greater than zero. The controller validates register availability and the upper index limit.

For command `101`:

- a value containing `.` is written as Real,
- a value without `.` is written as Integer,
- Integer values may have a leading `-`,
- Real values follow the protocol Real grammar.

Real values returned by command `100` are formatted with six digits after the decimal point.

Numeric Register comments can contain up to 16 characters. An empty comment clears the existing comment. `|` is not allowed in a comment.

### Examples

```text
100|1
```

```text
101|1|-25
```

```text
101|2|12.5
```

```text
103|1|PART COUNT
```

## String Registers

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `110` | Read String Register | `REGISTER_INDEX` | `VALUE` |
| `111` | Write String Register | `REGISTER_INDEX\|VALUE` | Empty |
| `112` | Read String Register comment | `REGISTER_INDEX` | `COMMENT` |
| `113` | Write String Register comment | `REGISTER_INDEX\|COMMENT` | Empty |

A String Register index must be greater than zero.

Leading and trailing spaces in String Register values are preserved. An empty value clears the register. The current protocol supports values up to 240 characters. `|` is not allowed in a value.

String Register comments can contain up to 16 characters. An empty comment clears the comment. `|` is not allowed in a comment.

## Position Registers

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `120` | Read Position Register type | `PR_INDEX;GROUP` | `POSITION_TYPE;NUMBER_OF_AXES` |
| `121` | Read Cartesian Position Register | `PR_INDEX;GROUP` | `X;Y;Z;W;P;R;CONFIG[;EXT1;EXT2;EXT3]` |
| `122` | Read Joint Position Register | `PR_INDEX;GROUP` | `J1;J2;...;Jn` |
| `123` | Write Cartesian Position Register | `PR_INDEX;GROUP;X;Y;Z;W;P;R;CONFIG[;EXT1;EXT2;EXT3]` | Empty |
| `124` | Write Joint Position Register | `PR_INDEX;GROUP;J1[;J2;...;J9]` | Empty |
| `125` | Read Position Register comment | `PR_INDEX` | `COMMENT` |
| `126` | Write Position Register comment | `PR_INDEX\|COMMENT` | Empty |

`PR_INDEX` and `GROUP` must be greater than zero.

### Position representation types

| Value | Representation |
|---:|---|
| `1` | `POSITION` |
| `2` | `XYZWPR` |
| `6` | `XYZWPREXT` |
| `9` | `JOINTPOS` |

For `JOINTPOS`, `NUMBER_OF_AXES` is the total number of Joint axes. For `XYZWPREXT`, it is the number of extended axes. For `XYZWPR`, it is normally zero.

Commands `121` and `123` support Cartesian representations. Commands `122` and `124` support Joint representation. A representation mismatch returns `-4`.

Cartesian values and Joint values returned by these commands use six decimal places. Cartesian data can contain up to three extended axes. Joint Position Register data can contain between one and nine axes.

Writing a Joint position may replace the previous Cartesian representation of the selected Position Register.

Position Register comments can contain up to 16 characters. An empty comment clears the comment. `|` is not allowed.

---

# I/O commands

For all I/O commands, the port index must be greater than zero. Port availability and the upper index limit are validated by the controller.

Boolean states use `0` for OFF and `1` for ON.

I/O comments can contain up to 24 characters. An empty comment clears the existing comment where comment writing is supported. `|` is reserved and cannot appear in comments.

A controller no-comment status is normalized to a successful empty response when the port itself is valid.

## Flags

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `200` | Read Flag | `FLAG_INDEX` | `0` or `1` |
| `201` | Write Flag | `FLAG_INDEX\|VALUE` | Empty |
| `202` | Read Flag comment | `FLAG_INDEX` | `COMMENT` |
| `203` | Write Flag comment | `FLAG_INDEX\|COMMENT` | Empty |

Command `201` accepts only `0` or `1`.

Command `201` accepts only `0` or `1`.

## Digital I/O

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `210` | Read Digital Input | `INPUT_INDEX` | `0` or `1` |
| `211` | Read Digital Input comment | `INPUT_INDEX` | `COMMENT` |
| `212` | Write Digital Input comment | `INPUT_INDEX\|COMMENT` | Empty |
| `213` | Read Digital Output | `OUTPUT_INDEX` | `0` or `1` |
| `214` | Write Digital Output | `OUTPUT_INDEX\|VALUE` | Empty |
| `215` | Read Digital Output comment | `OUTPUT_INDEX` | `COMMENT` |
| `216` | Write Digital Output comment | `OUTPUT_INDEX\|COMMENT` | Empty |

Command `214` accepts only `0` or `1`.

Command `214` accepts only `0` or `1`.

## Group I/O

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `220` | Read Group Input | `INPUT_INDEX` | Unsigned integer value |
| `221` | Read Group Input comment | `INPUT_INDEX` | `COMMENT` |
| `222` | Write Group Input comment | `INPUT_INDEX\|COMMENT` | Empty |
| `223` | Read Group Output | `OUTPUT_INDEX` | Unsigned integer value |
| `224` | Write Group Output | `OUTPUT_INDEX\|VALUE` | Empty |
| `225` | Read Group Output comment | `OUTPUT_INDEX` | `COMMENT` |
| `226` | Write Group Output comment | `OUTPUT_INDEX\|COMMENT` | Empty |

The value written by command `224` must contain unsigned decimal digits only and fit the configured group width.

Maximum accepted value:

```text
2^BIT_COUNT - 1
```

| Group width | Accepted range |
|---:|---:|
| 1 bit | `0-1` |
| 4 bits | `0-15` |
| 8 bits | `0-255` |
| 16 bits | `0-65535` |

## Analog I/O

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `230` | Read Analog Input | `INPUT_INDEX` | Raw integer value |
| `231` | Read Analog Input comment | `INPUT_INDEX` | `COMMENT` |
| `232` | Write Analog Input comment | `INPUT_INDEX\|COMMENT` | Empty |
| `233` | Read Analog Output | `OUTPUT_INDEX` | Raw integer value |
| `234` | Write Analog Output | `OUTPUT_INDEX\|VALUE` | Empty |
| `235` | Read Analog Output comment | `OUTPUT_INDEX` | `COMMENT` |
| `236` | Write Analog Output comment | `OUTPUT_INDEX\|COMMENT` | Empty |

Analog values are raw controller values. The protocol does not scale them to voltage, current, or engineering units.

Command `234` accepts unsigned integer values from `0` through `65535`.

## Robot I/O

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `240` | Read Robot Input | `INPUT_INDEX` | `0` or `1` |
| `241` | Read Robot Input comment | `INPUT_INDEX` | `COMMENT` |
| `242` | Write Robot Input comment | `INPUT_INDEX\|COMMENT` | Empty |
| `243` | Read Robot Output | `OUTPUT_INDEX` | `0` or `1` |
| `244` | Write Robot Output | `OUTPUT_INDEX\|VALUE` | Empty |
| `245` | Read Robot Output comment | `OUTPUT_INDEX` | `COMMENT` |
| `246` | Write Robot Output comment | `OUTPUT_INDEX\|COMMENT` | Empty |

Command `244` accepts only `0` or `1`.

Command `244` accepts only `0` or `1`.

## UOP and SOP

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `250` | Read UOP Input | `INPUT_INDEX` | `0` or `1` |
| `251` | Read UOP Input system comment | `INPUT_INDEX` | `COMMENT` |
| `252` | Read UOP Output | `OUTPUT_INDEX` | `0` or `1` |
| `253` | Read UOP Output system comment | `OUTPUT_INDEX` | `COMMENT` |
| `254` | Read SOP Input | `INPUT_INDEX` | `0` or `1` |
| `255` | Read SOP Input system comment | `INPUT_INDEX` | `COMMENT` |
| `256` | Read SOP Output | `OUTPUT_INDEX` | `0` or `1` |
| `257` | Read SOP Output system comment | `OUTPUT_INDEX` | `COMMENT` |

These UOP and SOP operations are read-only in the current protocol.

---

# Variable commands

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `300` | Read Boolean variable | `PROGRAM_NAME\|VARIABLE_NAME` | `0` or `1` |
| `301` | Write Boolean variable | `PROGRAM_NAME\|VARIABLE_NAME\|VALUE` | Empty |
| `302` | Read Integer variable | `PROGRAM_NAME\|VARIABLE_NAME` | Signed integer value |
| `303` | Write Integer variable | `PROGRAM_NAME\|VARIABLE_NAME\|VALUE` | Empty |
| `304` | Read Real variable | `PROGRAM_NAME\|VARIABLE_NAME` | Real value |
| `305` | Write Real variable | `PROGRAM_NAME\|VARIABLE_NAME\|VALUE` | Empty |
| `306` | Read String variable | `PROGRAM_NAME\|VARIABLE_NAME` | String value |
| `307` | Write String variable | `PROGRAM_NAME\|VARIABLE_NAME\|VALUE` | Empty |

Use:

```text
*SYSTEM*
```

as `PROGRAM_NAME` to access controller system variables.

Variable names can contain array indexes and nested structure fields.

`PROGRAM_NAME` and `VARIABLE_NAME` must not be empty. The command type must match the controller variable type, and writes require controller write access.

### Boolean values

```text
0 - FALSE
1 - TRUE
```

### Integer values

Integer writes accept signed decimal integers without a leading `+`.

### Real values

Real writes accept the protocol Real grammar. Scientific notation is not accepted in requests. Real reads are formatted by the controller in scientific notation with six digits after the decimal point.

### String values

An empty String value is accepted. A String value cannot contain `|`. If a String variable read returns a value containing `|`, the command returns `-3` with an empty response.

---

# Alarm and diagnostic commands

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `500` | Read latest alarm | Empty | Alarm record |
| `501` | Read next alarm-history entry | `SEQUENCE_NUMBER` | Alarm record |

Alarm record format:

```text
SEQUENCE_NUMBER^ERROR_CODE^ERROR_MESSAGE^CAUSE_CODE^CAUSE_MESSAGE^TIMESTAMP^SEVERITY^PROGRAM_NAME
```

| Field | Meaning |
|---|---|
| `SEQUENCE_NUMBER` | Controller error-history sequence number |
| `ERROR_CODE` | Alarm code |
| `ERROR_MESSAGE` | Alarm message |
| `CAUSE_CODE` | Cause code |
| `CAUSE_MESSAGE` | Cause message |
| `TIMESTAMP` | Controller-formatted alarm time |
| `SEVERITY` | Alarm severity |
| `PROGRAM_NAME` | Associated program name, possibly empty |

Severity values:

| Value | Meaning |
|---:|---|
| `0` | Warning |
| `1` | Pause |
| `2` | Abort |

Command `500` requests the newest available history entry.

For command `501`:

- sequence `0` requests the oldest available entry,
- a positive sequence requests the next available entry after it,
- sequence numbers do not have to be consecutive,
- an invalid sequence or no later entry returns `-3`.

The characters `|` and `^` in alarm text fields are replaced with spaces.

---

# Motion configuration commands

## User Frames

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `600` | Read User Frame | `GROUP_NUMBER|USER_FRAME_NUMBER` | `X;Y;Z;W;P;R;CONFIGURATION` |
| `601` | Write User Frame | `GROUP_NUMBER|USER_FRAME_NUMBER|X;Y;Z;W;P;R;CONFIGURATION` | Empty |
| `602` | Read User Frame comment | `GROUP_NUMBER|USER_FRAME_NUMBER` | `COMMENT` |
| `603` | Write User Frame comment | `GROUP_NUMBER|USER_FRAME_NUMBER|COMMENT` | Empty |
| `604` | Read active User Frame | `GROUP_NUMBER` | `USER_FRAME_NUMBER` |
| `605` | Set active User Frame | `GROUP_NUMBER|USER_FRAME_NUMBER` | Empty |

`GROUP_NUMBER` must be greater than zero.

Commands `600-603` require a positive User Frame number not exceeding the controller maximum. User Frame `0` is not a configured table entry.

Command `604` can return `0`, meaning World Frame is active. Command `605` accepts `0` to select World Frame.

Frame values use six decimal places. An empty comment clears the existing comment. `|` is not allowed in a comment.

## Tool Frames

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `610` | Read Tool Frame | `GROUP_NUMBER|TOOL_FRAME_NUMBER` | `X;Y;Z;W;P;R;CONFIGURATION` |
| `611` | Write Tool Frame | `GROUP_NUMBER|TOOL_FRAME_NUMBER|X;Y;Z;W;P;R;CONFIGURATION` | Empty |
| `612` | Read Tool Frame comment | `GROUP_NUMBER|TOOL_FRAME_NUMBER` | `COMMENT` |
| `613` | Write Tool Frame comment | `GROUP_NUMBER|TOOL_FRAME_NUMBER|COMMENT` | Empty |
| `614` | Read active Tool Frame | `GROUP_NUMBER` | `TOOL_FRAME_NUMBER` |
| `615` | Set active Tool Frame | `GROUP_NUMBER|TOOL_FRAME_NUMBER` | Empty |

`GROUP_NUMBER` must be greater than zero.

Commands `610-613` require a positive Tool Frame number not exceeding the controller maximum.

Command `614` can return `0`. Command `615` accepts `0` to select Tool Frame number zero.

Frame values use six decimal places. An empty comment clears the existing comment. `|` is not allowed in a comment.

## Payloads

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `620` | Read Payload Schedule | `GROUP_NUMBER|PAYLOAD_NUMBER` | `MASS;X;Y;Z;IX;IY;IZ` |
| `621` | Write Payload Schedule | `GROUP_NUMBER|PAYLOAD_NUMBER|MASS;X;Y;Z;IX;IY;IZ` | Empty |
| `622` | Read Payload Schedule comment | `GROUP_NUMBER|PAYLOAD_NUMBER` | `COMMENT` |
| `623` | Write Payload Schedule comment | `GROUP_NUMBER|PAYLOAD_NUMBER|COMMENT` | Empty |
| `624` | Read active Payload Schedule | `GROUP_NUMBER` | `PAYLOAD_NUMBER` |
| `625` | Set active Payload Schedule | `GROUP_NUMBER|PAYLOAD_NUMBER` | Empty |

`GROUP_NUMBER` must be greater than zero. Commands `620-623` require a positive Payload Schedule number that does not exceed the configured schedule count.

Payload format:

```text
MASS;X;Y;Z;IX;IY;IZ
```

Rules:

- `MASS` must be from `0` through the maximum payload configured for the Motion Group,
- `X`, `Y`, and `Z` can be negative,
- `IX`, `IY`, and `IZ` must be nonnegative,
- payload reads use six decimal places.

Payload writes are not transactional. If a later field write fails, fields written earlier in the sequence remain modified.

An empty Payload comment clears the existing comment. `|` is not allowed in a comment.

Command `624` can return `0`. Command `625` accepts `0` or a positive schedule number not exceeding the configured schedule count.

---

# Robot position and Motion commands

## Current position

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `700` | Read current Cartesian position | `GROUP_NUMBER` | `X;Y;Z;W;P;R;CONFIGURATION` |
| `701` | Read current Joint position | `GROUP_NUMBER` | `J1;J2;J3;J4;J5;J6` |

`GROUP_NUMBER` must be greater than zero.

Command `700` returns the current TCP position relative to the active User Frame with the active Tool Frame applied.

Command `701` currently returns exactly six Joint values.

Values use six decimal places.

## Cartesian reachability

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `702` | Check Cartesian target | `GROUP|UFRAME|UTOOL|X;Y;Z;W;P;R;CONFIGURATION` | `REACHABLE;CHECK_STATUS` |

Reachable target:

```text
1;0
```

Rejected target:

```text
0;CHECK_STATUS
```

A rejected target is a valid check result. When the check itself completes successfully, operation status remains `0` even when `REACHABLE` is `0`.

Rules:

- `GROUP` must be greater than zero,
- `UFRAME` and `UTOOL` can be zero,
- `UFRAME[0]` represents World Frame,
- `UTOOL[0]` represents the identity tool transformation at the faceplate,
- positive frame numbers cannot exceed controller limits,
- extended axes are not accepted.

## Start Joint Motion

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `710` | Start Joint Motion | `GROUP|UFRAME|UTOOL|SPEED|TERMINATION|POSITION_TYPE|POSITION` | Empty |

Joint Motion rules:

- `GROUP` must be greater than zero,
- `UFRAME` and `UTOOL` can be zero,
- `SPEED` is an integer percentage from `1` through `100`,
- `TERMINATION` is `-1` for FINE or `0-100` for CNT,
- `POSITION_TYPE` is `2` for Cartesian or `9` for Joint,
- Cartesian extended axes are not supported,
- Joint targets contain exactly six axes.

Cartesian example:

```text
710|1|0|1|100|-1|2|100;200;300;0;0;90;N U T, 0, 0, 0
```

Joint example:

```text
710|1|0|1|100|50|9|-90;45;0;0;-90;0
```

## Start Linear Motion

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `711` | Start Linear Motion | `GROUP|UFRAME|UTOOL|SPEED|TERMINATION|POSITION_TYPE|POSITION` | Empty |

Linear Motion uses the same target, frame, and termination formats as command `710`.

Differences:

- `SPEED` is a positive integer in `mm/sec`,
- the protocol does not enforce a local upper speed limit,
- the controller limits actual execution according to the robot configuration.

## Motion concurrency

Only one FanucX Motion can be Accepted or Running at a time. A new `710` or `711` request is rejected with `-3` while the current status is:

```text
1 - Accepted
2 - Running
```

A successful start response means that the request was accepted and Motion execution started. It does not mean that Motion has completed.

## Motion status

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `720` | Read Motion status | Empty | `MOTION_TYPE;GROUP;STATUS;RESULT;ERROR` |

Motion types:

| Value | Meaning |
|---:|---|
| `0` | None |
| `1` | Joint |
| `2` | Linear |

Motion statuses:

| Value | Meaning |
|---:|---|
| `0` | Idle |
| `1` | Accepted |
| `2` | Running |
| `3` | Completed |
| `4` | Failed |
| `5` | Aborted |
| `6` | Rejected |

Motion results:

| Value | Meaning |
|---:|---|
| `0` | No successful result |
| `1` | Motion completed successfully |

`ERROR` is zero when no Motion error is recorded. A nonzero value contains a controller or FanucX execution status.

## Abort Motion

| Code | Operation | Request arguments | Response arguments |
|---:|---|---|---|
| `721` | Abort active FanucX Motion | Empty | Empty |

Abort is accepted only while Motion status is `1` or `2`.

After a successful abort:

```text
STATUS = 5
RESULT = 0
ERROR = 0
```

Calling `721` without an active Accepted or Running Motion returns `-3`.

The abort operation targets only the FanucX Motion task. It does not perform a global controller abort.

---

# Current implementation limitations

- Messages are limited by `STRING[254]` controller buffers
- Only one request may be active per connection
- Request pipelining is not supported
- The protocol has no general escaping mechanism for `|`
- Scientific notation is not accepted in Real request fields
- Motion supports six-axis Joint targets and Cartesian targets without extended axes
- Position Register operations support up to nine Joint axes and three Cartesian extended axes
- Motion execution uses Motion Group 1 in the installed executor
- Reserved command ranges are not implemented

---

# Compatibility

The handshake protocol version is:

```text
1
```

The Python package and controller server must support the same protocol version. A client must reject an incompatible handshake.

Changes that alter message framing, separator meaning, command codes, response field order, or status semantics require a protocol-version review.
