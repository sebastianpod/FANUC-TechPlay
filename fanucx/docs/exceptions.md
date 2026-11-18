# Exceptions

FanucX exposes public exceptions for connection, communication, protocol, and controller-operation failures.

```python
from fanucx import (
    RobotCommunicationError,
    RobotConnectionError,
    RobotNotConnectedError,
    RobotOperationError,
    RobotProtocolError,
)
```

All FanucX-specific exceptions inherit from Python's built-in `Exception` class.

---

## RobotNotConnectedError

Raised when an operation requires an active robot connection, but `Robot.connect()` has not been called or the connection has already been closed.

```python
from fanucx import Robot, RobotNotConnectedError


robot = Robot(
    host="192.168.0.10",
    port=12345,
    timeout=5,
)

try:
    value = robot.r[1]
except RobotNotConnectedError as error:
    print(error)
```

Call `connect()` before performing robot operations:

```python
robot.connect()
```

---

## RobotConnectionError

Raised when FanucX cannot establish the initial TCP connection to the robot.

Typical causes include:

- incorrect robot address or port,
- unavailable FanucX server,
- network routing or firewall problems,
- connection timeout,
- controller communication service not running.

```python
from fanucx import Robot, RobotConnectionError


try:
    robot.connect()
except RobotConnectionError as error:
    print(error)
```

---

## RobotCommunicationError

Raised when communication fails after a connection has been established.

Typical causes include:

- socket timeout,
- connection reset,
- incomplete response,
- robot controller shutdown,
- FanucX server termination,
- network interruption.

```python
from fanucx import RobotCommunicationError


try:
    position = robot.cartesian()
except RobotCommunicationError as error:
    print(error)
```

A `RobotCommunicationError` means that the final state of the requested operation may be unknown. Before retrying a write or motion request, verify the relevant robot state.

---

## RobotOperationError

Raised when the request reaches the controller, but the requested operation is rejected.

Typical causes include:

- unknown register, variable, frame, or program,
- unsupported Motion Group,
- target-type mismatch,
- invalid controller-side value,
- write-protected resource,
- motion already active,
- motion start failure,
- abort requested without an active FanucX motion.

```python
from fanucx import RobotOperationError


try:
    robot.abort_motion()
except RobotOperationError as error:
    print(error)
```

The exception message includes the controller or FanucX operation status when available:

```text
Robot operation failed. Error code: 16006
```

Controller error codes depend on the controller software, installed options, and requested operation.

---

## RobotProtocolError

Raised when the controller response does not match the format expected by FanucX.

Typical causes include:

- missing response fields,
- unexpected field count,
- invalid Boolean response,
- non-numeric Integer, Real, position, or status value,
- unsupported response type,
- incompatible Python and KAREL server versions.

```python
from fanucx import RobotProtocolError


try:
    status = robot.movej(target)
except RobotProtocolError as error:
    print(error)
```

A `RobotProtocolError` usually indicates an invalid server response or a version mismatch rather than rejection of a valid controller operation.

---

# Handling FanucX exceptions

Handle specific exceptions before more general ones:

```python
from fanucx import (
    RobotCommunicationError,
    RobotConnectionError,
    RobotNotConnectedError,
    RobotOperationError,
    RobotProtocolError,
)


try:
    robot.connect()

    result = robot.movej(
        target,
        speed=50,
        termination="FINE",
        group=1,
        uframe=0,
        utool=1,
    )

except RobotConnectionError as error:
    print(f"Could not connect: {error}")

except RobotNotConnectedError as error:
    print(f"No active connection: {error}")

except RobotCommunicationError as error:
    print(f"Communication failed: {error}")

except RobotOperationError as error:
    print(f"Controller rejected the operation: {error}")

except RobotProtocolError as error:
    print(f"Invalid response: {error}")

finally:
    robot.disconnect()
```

Python's built-in `TypeError` and `ValueError` are used for invalid local arguments:

```python
robot.movej(target, speed=True)
# TypeError

robot.movej(target, speed=101)
# ValueError
```

These errors are detected before the request is sent to the controller.
