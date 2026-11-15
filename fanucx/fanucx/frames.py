from .exceptions import RobotProtocolError
from .positions import (
    CartesianConfiguration,
    CartesianPosition,
)
from .validation import _validate_register_index


_FRAME_COMMENT_MAX_LENGTH = 29


def _validate_active_frame_number(frame_number):
    if not isinstance(frame_number, int) or isinstance(frame_number, bool):
        raise TypeError(f"Active frame number must be an integer, received {type(frame_number).__name__}")

    if frame_number < 0:
        raise ValueError(f"Active frame number must be greater than or equal to zero, received {frame_number}")

def _parse_frame(response_arguments, frame_name):
    frame_fields = response_arguments.split(";")

    if len(frame_fields) != 7:
        raise RobotProtocolError(f"Invalid {frame_name} format. Expected 7 fields, received {len(frame_fields)}")

    try:
        x = float(frame_fields[0])
        y = float(frame_fields[1])
        z = float(frame_fields[2])
        w = float(frame_fields[3])
        p = float(frame_fields[4])
        r = float(frame_fields[5])

    except ValueError as error:
        raise RobotProtocolError(f"Invalid {frame_name} format. All Cartesian components must be numeric. Received fields: {frame_fields}") from error

    try:
        configuration = CartesianConfiguration(frame_fields[6])

    except (TypeError, ValueError) as error:
        raise RobotProtocolError(f"Invalid {frame_name} configuration. Received {frame_fields[6]!r}") from error

    return CartesianPosition(
        x=x,
        y=y,
        z=z,
        w=w,
        p=p,
        r=r,
        configuration=configuration,
    )


def _serialize_frame(position, frame_name):
    if not isinstance(position, CartesianPosition):
        raise TypeError(f"{frame_name} value must be a CartesianPosition, received {type(position).__name__}")

    if position.extended_axes:
        raise ValueError(f"{frame_name} cannot contain extended axes. Received {len(position.extended_axes)} extended axes")

    position_fields = [
        str(position.x),
        str(position.y),
        str(position.z),
        str(position.w),
        str(position.p),
        str(position.r),
        position.configuration.value,
    ]

    return ";".join(position_fields)

def _validate_frame_comment(comment, frame_name):
    if not isinstance(comment, str):
        raise TypeError(f"{frame_name} comment must be a string, received {type(comment).__name__}")

    if len(comment) > _FRAME_COMMENT_MAX_LENGTH:
        raise ValueError(f"{frame_name} comment cannot exceed {_FRAME_COMMENT_MAX_LENGTH} characters. Received {len(comment)} characters")

    if "|" in comment:
        raise ValueError(f"{frame_name} comment cannot contain the reserved protocol separator '|'")

class UserFrameComments:
    """Provides indexed access to FANUC User Frame comments."""

    def __init__(self, robot):
        self._robot = robot

    def get(self, frame_number, group=1):
        _validate_register_index(frame_number)
        _validate_register_index(group)

        return self._robot._request(602, group,frame_number)

    def set(self, frame_number, comment, group=1):
        _validate_register_index(frame_number)
        _validate_register_index(group)

        _validate_frame_comment(comment, "User Frame")

        self._robot._request(603, group, frame_number, comment)

    def __getitem__(self, frame_number):
        return self.get(frame_number, group=1)

    def __setitem__(self, frame_number, comment):
        self.set(frame_number, comment, group=1)

class UserFrames:
    """Provides indexed access to FANUC User Frames."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = UserFrameComments(robot)

    def get(self, frame_number, group=1):
        _validate_register_index(frame_number)
        _validate_register_index(group)

        response_arguments = self._robot._request(600, group, frame_number)

        return _parse_frame(response_arguments, "User Frame")

    def set(self, frame_number, position, group=1):
        _validate_register_index(frame_number)
        _validate_register_index(group)

        serialized_position = _serialize_frame(position, "User Frame")

        self._robot._request(601, group, frame_number, serialized_position)

    def __getitem__(self, frame_number):
        return self.get(frame_number, group=1)

    def __setitem__(self, frame_number, position):
        self.set(frame_number, position, group=1)

    def get_active(self, group=1):
        _validate_register_index(group)

        response_arguments = self._robot._request(604, group)

        try:
            active_frame_number = int(response_arguments)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid active User Frame response. Expected an integer, received {response_arguments!r}") from error

        if active_frame_number < 0:
            raise RobotProtocolError(f"Active User Frame number cannot be negative. Received {active_frame_number}")

        return active_frame_number

    def set_active(self, frame_number, group=1):
        _validate_active_frame_number(frame_number)
        _validate_register_index(group)

        self._robot._request(605, group, frame_number)

    @property
    def active(self):
        """Returns the active User Frame for Motion Group 1."""

        return self.get_active(group=1)

    @active.setter
    def active(self, frame_number):
        """Sets the active User Frame for Motion Group 1."""

        self.set_active(frame_number, group=1)


class ToolFrameComments:
    """Provides indexed access to FANUC Tool Frame comments."""

    def __init__(self, robot):
        self._robot = robot

    def get(self, frame_number, group=1):
        _validate_register_index(frame_number)
        _validate_register_index(group)

        return self._robot._request(612, group, frame_number)

    def set(self, frame_number, comment, group=1):
        _validate_register_index(frame_number)
        _validate_register_index(group)

        _validate_frame_comment(comment, "Tool Frame")

        self._robot._request(613, group, frame_number, comment)

    def __getitem__(self, frame_number):
        return self.get(frame_number, group=1)

    def __setitem__(self, frame_number, comment):
        self.set(frame_number, comment, group=1)

class ToolFrames:
    """Provides indexed access to FANUC Tool Frames."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = ToolFrameComments(robot)

    def get(self, frame_number, group=1):
        _validate_register_index(frame_number)
        _validate_register_index(group)

        response_arguments = self._robot._request(610, group, frame_number)

        return _parse_frame(response_arguments, "Tool Frame")

    def set(self, frame_number, position, group=1):
        _validate_register_index(frame_number)
        _validate_register_index(group)

        serialized_position = _serialize_frame(position, "Tool Frame")

        self._robot._request(611, group, frame_number, serialized_position)

    def __getitem__(self, frame_number):
        return self.get(frame_number, group=1)

    def __setitem__(self, frame_number, position):
        self.set(frame_number, position, group=1)

    def get_active(self, group=1):
        _validate_register_index(group)

        response_arguments = self._robot._request(614, group)

        try:
            active_frame_number = int(response_arguments)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid active Tool Frame response. Expected an integer, received {response_arguments!r}") from error

        if active_frame_number < 0:
            raise RobotProtocolError(f"Active Tool Frame number cannot be negative. Received {active_frame_number}")

        return active_frame_number

    def set_active(self, frame_number, group=1):
        _validate_active_frame_number(frame_number)
        _validate_register_index(group)

        self._robot._request(615, group, frame_number)

    @property
    def active(self):
        """Returns the active Tool Frame for Motion Group 1."""

        return self.get_active(group=1)

    @active.setter
    def active(self, frame_number):
        """Sets the active Tool Frame for Motion Group 1."""

        self.set_active(frame_number, group=1)

    