from ..exceptions import RobotProtocolError
from ..validation import _validate_register_index


class GroupInputComments:
    """Provides indexed read and write access to FANUC Group Input comments."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, index):
        _validate_register_index(index)

        return self._robot._request(221, index)

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, str):
            raise TypeError(f"Group Input comment must be a string, received {type(value).__name__}.")

        if len(value) > 24:
            raise ValueError(f"Group Input comment cannot exceed 24 characters. Received {len(value)} characters.")

        if "|" in value:
            raise ValueError("Group Input comment cannot contain the reserved protocol separator '|'.")

        self._robot._request(222, index, value)


class GroupInputs:
    """Provides indexed read access to FANUC Group Inputs."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = GroupInputComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)

        received_value = self._robot._request(220, index)

        try:
            return int(received_value)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid Group Input response. Expected an integer, received '{received_value}'.") from error


class GroupOutputComments:
    """Provides indexed read and write access to FANUC Group Output comments."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, index):
        _validate_register_index(index)

        return self._robot._request(225, index)

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, str):
            raise TypeError(f"Group Output comment must be a string, received {type(value).__name__}.")

        if len(value) > 24:
            raise ValueError(f"Group Output comment cannot exceed 24 characters. Received {len(value)} characters.")

        if "|" in value:
            raise ValueError("Group Output comment cannot contain the reserved protocol separator '|'.")

        self._robot._request(226, index, value)


class GroupOutputs:
    """Provides indexed read and write access to FANUC Group Outputs."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = GroupOutputComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)

        received_value = self._robot._request(223, index)

        try:
            return int(received_value)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid Group Output response. Expected an integer, received '{received_value}'.") from error

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, int) or isinstance(value, bool):
            raise TypeError(f"Group Output value must be an integer, received {type(value).__name__}.")

        if value < 0:
            raise ValueError(f"Group Output value must be greater than or equal to zero, received {value}.")

        self._robot._request(224, index, value)