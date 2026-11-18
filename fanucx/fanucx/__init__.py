"""Public API for the FanucX Python package."""

__version__ = "0.1.0"



from .exceptions import (
    RobotCommunicationError,
    RobotConnectionError,
    RobotNotConnectedError,
    RobotOperationError,
    RobotProtocolError,
)

from .positions import (
    CartesianConfiguration,
    CartesianPosition,
    JointPosition,
)

from .robot import Robot

from .variables import Variables

from .alarms import (
    Alarm,
    Alarms,
    AlarmSeverity,
)

from .frames import (
    ToolFrameComments,
    ToolFrames,
    UserFrameComments,
    UserFrames,
)

from .payloads import (
    Payload,
    PayloadComments,
    Payloads,
)

__all__ = [
    "Robot",
    "CartesianConfiguration",
    "CartesianPosition",
    "JointPosition",
    "RobotCommunicationError",
    "RobotConnectionError",
    "RobotNotConnectedError",
    "RobotOperationError",
    "RobotProtocolError",
    "Variables",
    "Alarm",
    "Alarms",
    "AlarmSeverity",
    "ToolFrameComments",
    "ToolFrames",
    "UserFrameComments",
    "UserFrames",
    "Payload",
    "PayloadComments",
    "Payloads",
    "__version__",
]