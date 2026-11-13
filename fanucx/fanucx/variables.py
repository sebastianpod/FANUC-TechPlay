from .exceptions import RobotProtocolError


class Variables:
    """Provides typed read and write access to FANUC variables."""

    def __init__(self, robot):
        self._robot = robot

    @staticmethod
    def _validate_variable_path(program, variable):
        if not isinstance(program, str):
            raise TypeError(f"Program name must be a string, received {type(program).__name__}")

        if not program:
            raise ValueError("Program name cannot be empty.")

        if "|" in program:
            raise ValueError("Program name cannot contain the reserved protocol separator '|'")

        if not isinstance(variable, str):
            raise TypeError(f"Variable name must be a string, received {type(variable).__name__}")

        if not variable:
            raise ValueError("Variable name cannot be empty.")

        if "|" in variable:
            raise ValueError("Variable name cannot contain the reserved protocol separator '|'")

    def get_boolean(self, program, variable):
        self._validate_variable_path(program, variable)

        received_value = self._robot._request(300, program, variable)

        if received_value == "1":
            return True

        if received_value == "0":
            return False

        raise RobotProtocolError(f"Invalid Boolean variable response. Expected '0' or '1', received '{received_value}'")

    def set_boolean(self, program, variable, value):
        self._validate_variable_path(program, variable)

        if not isinstance(value, bool):
            raise TypeError(f"Boolean variable value must be a bool, received {type(value).__name__}")

        protocol_value = 1 if value else 0

        self._robot._request(301, program, variable, protocol_value)

    def get_integer(self, program, variable):
        self._validate_variable_path(program, variable)

        received_value = self._robot._request(302, program, variable)

        try:
            return int(received_value)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid Integer variable response. Expected an integer, received '{received_value}'") from error

    def set_integer(self, program, variable, value):
        self._validate_variable_path(program, variable)

        if not isinstance(value, int) or isinstance(value, bool):
            raise TypeError(f"Integer variable value must be an integer, received {type(value).__name__}")

        self._robot._request(303, program, variable, value)

    def get_real(self, program, variable):
        self._validate_variable_path(program, variable)

        received_value = self._robot._request(304, program, variable)

        try:
            return float(received_value)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid Real variable response. Expected a real number, received '{received_value}'") from error

    def set_real(self, program, variable, value):
        self._validate_variable_path(program, variable)

        if (not isinstance(value, (int, float)) or isinstance(value, bool)):
            raise TypeError(f"Real variable value must be an integer or float, received {type(value).__name__}")

        self._robot._request(305, program, variable, value)

    def get_string(self, program, variable):
        self._validate_variable_path(program, variable)

        return self._robot._request(306, program, variable)

    def set_string(self, program, variable, value):
        self._validate_variable_path(program, variable)

        if not isinstance(value, str):
            raise TypeError(f"String variable value must be a string, received {type(value).__name__}")

        if "|" in value:
            raise ValueError("String variable value cannot contain the reserved protocol separator '|'")

        self._robot._request(307, program, variable, value)