from .exceptions import RobotProtocolError


def _parse_variable_key(key):
    if not isinstance(key, tuple):
        raise TypeError(f"Variable access key must be a tuple containing (program, variable), received {type(key).__name__}")

    if len(key) != 2:
        raise ValueError(f"Variable access key must contain exactly two values: (program, variable). Received {len(key)} values")

    program, variable = key

    if not isinstance(program, str):
        raise TypeError(f"Program or access path must be a string, received {type(program).__name__}")

    if not program:
        raise ValueError("Program or access path cannot be empty.")

    if "|" in program:
        raise ValueError("Program or access path cannot contain the reserved protocol separator '|'")

    if not isinstance(variable, str):
        raise TypeError(f"Variable path must be a string, received {type(variable).__name__}")

    if not variable:
        raise ValueError("Variable path cannot be empty.")

    if "|" in variable:
        raise ValueError("Variable path cannot contain the reserved protocol separator '|'")

    return program, variable


class BooleanVariables:
    """Provides indexed read and write access to Boolean variables."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, key):
        program, variable = _parse_variable_key(key)
        received_value = self._robot._request(300, program, variable)

        if received_value == "1":
            return True

        if received_value == "0":
            return False

        raise RobotProtocolError(f"Invalid Boolean variable response. Expected '0' or '1', received {received_value!r}")

    def __setitem__(self, key, value):
        program, variable = _parse_variable_key(key)

        if not isinstance(value, bool):
            raise TypeError(f"Boolean variable value must be a bool, received {type(value).__name__}")

        protocol_value = 1 if value else 0

        self._robot._request(301, program, variable, protocol_value)


class IntegerVariables:
    """Provides indexed read and write access to Integer variables."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, key):
        program, variable = _parse_variable_key(key)
        received_value = self._robot._request(302, program, variable)

        try:
            return int(received_value)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid Integer variable response. Expected an integer, received {received_value!r}") from error

    def __setitem__(self, key, value):
        program, variable = _parse_variable_key(key)

        if not isinstance(value, int) or isinstance(value, bool):
            raise TypeError(f"Integer variable value must be an integer, received {type(value).__name__}")

        self._robot._request(303, program, variable, value)


class RealVariables:
    """Provides indexed read and write access to Real variables."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, key):
        program, variable = _parse_variable_key(key)
        received_value = self._robot._request(304, program, variable)

        try:
            return float(received_value)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid Real variable response. Expected a real number, received {received_value!r}") from error

    def __setitem__(self, key, value):
        program, variable = _parse_variable_key(key)

        if not isinstance(value, (int, float)) or isinstance(value, bool):
            raise TypeError(f"Real variable value must be an integer or float, received {type(value).__name__}")

        self._robot._request(305, program, variable, value)


class StringVariables:
    """Provides indexed read and write access to String variables."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, key):
        program, variable = _parse_variable_key(key)
        return self._robot._request(306, program, variable)

    def __setitem__(self, key, value):
        program, variable = _parse_variable_key(key)

        if not isinstance(value, str):
            raise TypeError(f"String variable value must be a string, received {type(value).__name__}")

        if "|" in value:
            raise ValueError("String variable value cannot contain the reserved protocol separator '|'")

        self._robot._request(307, program, variable, value)


class Variables:
    """Provides typed indexed access to FANUC variables"""

    def __init__(self, robot):
        self.boolean = BooleanVariables(robot)
        self.integer = IntegerVariables(robot)
        self.real = RealVariables(robot)
        self.string = StringVariables(robot)