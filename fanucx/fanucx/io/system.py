from ..exceptions import RobotProtocolError
from ..validation import _validate_register_index


class ReadOnlyPortComments:
    """Provides indexed read access to I/O port comments."""

    def __init__(self, robot, command_code):
        self._robot = robot
        self._command_code = command_code

    def __getitem__(self, index):
        _validate_register_index(index)
        return self._robot._request(self._command_code, index)


class ReadOnlyBooleanPorts:
    """Provides indexed read access to Boolean I/O ports."""

    def __init__(self, robot, value_command, comment_command):
        self._robot = robot
        self._value_command = value_command
        self.comment = ReadOnlyPortComments(robot,comment_command,)

    def __getitem__(self, index):
        _validate_register_index(index)

        received_value = self._robot._request(self._value_command, index,)

        if received_value == "1":
            return True

        if received_value == "0":
            return False

        raise RobotProtocolError(f"Invalid Boolean port response. Expected '0' or '1', received '{received_value}'.")
    