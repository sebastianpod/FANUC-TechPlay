from ..exceptions import RobotProtocolError
from ..validation import _validate_register_index


class FlagComments:
    """Provides indexed read and write access to FANUC flag comments."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, index):
        _validate_register_index(index)

        return self._robot._request(202, index)

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, str):
            raise TypeError(f"Flag comment must be a string, received {type(value).__name__}.")

        if len(value) > 24:
            raise ValueError(f"Flag comment cannot exceed 24 characters. Received {len(value)} characters")

        if "|" in value:
            raise ValueError("Flag comment cannot contain the reserved protocol separator '|'")

        self._robot._request(203, index, value)


class Flags:
    """Provides indexed read and write access to FANUC flags."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = FlagComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)

        received_value = self._robot._request(200, index)

        if received_value == "1":
            return True

        if received_value == "0":
            return False

        raise RobotProtocolError(f"Invalid flag response. Expected '0' or '1', received '{received_value}'.")

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, bool):
            raise TypeError(f"Flag value must be a bool, received {type(value).__name__}.")

        if value:
            protocol_value = 1
        else:
            protocol_value = 0

        self._robot._request(201, index, protocol_value)