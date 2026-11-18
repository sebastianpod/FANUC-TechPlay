class RobotNotConnectedError(Exception):
    """Raised when an operation requires an active robot connection"""


class RobotOperationError(Exception):
    """Raised when the robot controller rejects a requested operation"""


class RobotProtocolError(Exception):
    """Raised when a robot response does not match the FanucX protocol"""


class RobotConnectionError(Exception):
    """Raised when the initial connection to the robot cannot be established"""


class RobotCommunicationError(Exception):
    """Raised when communication fails after connecting to the robot"""
