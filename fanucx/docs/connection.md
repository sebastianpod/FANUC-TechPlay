# Connection

FanucX communicates with the robot controller through a TCP connection managed by the `Robot` class.

```python
from fanucx import Robot
```

---

## Creating a Robot instance

Create a `Robot` instance with the controller address, FanucX server port, and connection timeout:

```python
robot = Robot(
    host="192.168.0.10",
    port=12345,
    timeout=5,
)
```

Constructor arguments:

| Argument | Description |
|---|---|
| `host` | Robot controller hostname or IP address |
| `port` | TCP port used by the FanucX server |
| `timeout` | Socket timeout in seconds |

Creating a `Robot` instance does not open a network connection. Call `connect()` before using robot operations.

---

## Connecting

Open the TCP connection:

```python
robot.connect()
```

During connection setup, FanucX validates the server handshake. The connection succeeds only when the server returns the expected FanucX handshake.

Calling `connect()` when the `Robot` instance is already connected has no effect.

```python
robot.connect()
robot.connect()
```

The second call does not create another socket connection.

---

## Disconnecting

Close the active connection:

```python
robot.disconnect()
```

Calling `disconnect()` when no connection is active is safe and has no effect.

```python
robot.disconnect()
robot.disconnect()
```

After disconnection, operations requiring communication raise `RobotNotConnectedError` until `connect()` is called again.

---

## Recommended connection lifecycle

Use `try` and `finally` to ensure that the socket is closed even when an operation raises an exception:

```python
from fanucx import Robot


robot = Robot(
    host="192.168.0.10",
    port=12345,
    timeout=5,
)

robot.connect()

try:
    position = robot.cartesian()
    print(position)
finally:
    robot.disconnect()
```

A `Robot` instance can be connected again after `disconnect()`:

```python
robot.connect()
robot.disconnect()

robot.connect()
robot.disconnect()
```

---

## Connection timeout

The `timeout` argument is applied to connection setup and subsequent socket communication.

```python
robot = Robot(
    host="192.168.0.10",
    port=12345,
    timeout=10,
)
```

A short timeout detects unavailable controllers quickly but may be unsuitable for slow or unstable networks. A longer timeout allows more time for the controller to respond but also delays failure reporting.

The default timeout is 5 seconds.

---

## Connection errors

### RobotNotConnectedError

Raised when an operation requires an active connection but the robot is not connected:

```python
from fanucx import Robot, RobotNotConnectedError


robot = Robot("192.168.0.10", 12345)

try:
    robot.cartesian()
except RobotNotConnectedError as error:
    print(error)
```

Call `connect()` before performing robot operations.

### RobotConnectionError

Raised when the initial TCP connection cannot be established or is closed before the handshake is received.

Typical causes include:

- incorrect hostname or IP address,
- incorrect TCP port,
- FanucX server not running,
- connection refusal,
- connection timeout,
- network routing or firewall problems,
- controller unavailable during connection setup.

```python
from fanucx import RobotConnectionError


try:
    robot.connect()
except RobotConnectionError as error:
    print(error)
```

### RobotProtocolError

Raised during connection setup when the server handshake is invalid or cannot be decoded as UTF-8.

```python
from fanucx import RobotProtocolError


try:
    robot.connect()
except RobotProtocolError as error:
    print(error)
```

An invalid handshake usually indicates that the configured address or port does not point to a compatible FanucX server.

### RobotCommunicationError

Raised when communication fails after the connection has been established.

Typical causes include:

- response timeout,
- connection reset,
- broken socket,
- FanucX server termination,
- controller shutdown,
- network interruption,
- server closing the connection before sending a complete response.

```python
from fanucx import RobotCommunicationError


try:
    position = robot.cartesian()
except RobotCommunicationError as error:
    print(error)
```

When a communication failure occurs during a write or motion operation, the final controller state may be unknown. Read the relevant state before repeating the operation.

---

## Handling connection and communication errors

```python
from fanucx import (
    Robot,
    RobotCommunicationError,
    RobotConnectionError,
    RobotNotConnectedError,
    RobotProtocolError,
)


robot = Robot(
    host="192.168.0.10",
    port=12345,
    timeout=5,
)

try:
    robot.connect()
    position = robot.cartesian()
    print(position)

except RobotConnectionError as error:
    print(f"Could not connect: {error}")

except RobotNotConnectedError as error:
    print(f"No active connection: {error}")

except RobotCommunicationError as error:
    print(f"Communication failed: {error}")

except RobotProtocolError as error:
    print(f"Invalid FanucX response: {error}")

finally:
    robot.disconnect()
```

---

## Connection ownership

A `Robot` instance owns one TCP socket connection.

Do not issue concurrent requests through the same `Robot` instance from multiple threads or asynchronous tasks unless access is explicitly synchronized by the application. FanucX uses a request-response protocol, so overlapping requests on one socket can associate a response with the wrong operation.

Use one clear owner for each connected `Robot` instance and complete one request before starting another.

---

## Console output

`connect()` and `disconnect()` do not print status messages. Applications can display or log connection state using their own logging strategy:

```python
robot.connect()
print("Connected")

try:
    position = robot.cartesian()
finally:
    robot.disconnect()
    print("Disconnected")
```

This allows FanucX to be used cleanly in command-line tools, automated tests, graphical applications, and services without writing directly to standard output.

---

## Quick reference

```python
from fanucx import Robot


robot = Robot(
    host="192.168.0.10",
    port=12345,
    timeout=5,
)

robot.connect()

try:
    print(robot.cartesian())
    print(robot.joints())
finally:
    robot.disconnect()
```
