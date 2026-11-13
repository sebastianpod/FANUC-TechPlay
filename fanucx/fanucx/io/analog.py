from ..exceptions import RobotProtocolError
from ..validation import _validate_register_index


class AnalogInputComments:
    """Provides indexed read and write access to FANUC Analog Input comments."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, index):
        _validate_register_index(index)

        return self._robot._request(231, index)

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, str):
            raise TypeError(f"Analog Input comment must be a string, received {type(value).__name__}.")

        if len(value) > 24:
            raise ValueError(f"Analog Input comment cannot exceed 24 characters. Received {len(value)} characters.")

        if "|" in value:
            raise ValueError("Analog Input comment cannot contain the reserved protocol separator '|'.")

        self._robot._request(232, index, value)


class AnalogInputs:
    """Provides indexed read access to FANUC Analog Inputs."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = AnalogInputComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)

        received_value = self._robot._request(230, index)

        try:
            return int(received_value)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid Analog Input response. Expected an integer, received '{received_value}'.") from error


class AnalogOutputComments:
    """Provides indexed read and write access to FANUC Analog Output comments."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, index):
        _validate_register_index(index)

        return self._robot._request(235, index)

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, str):
            raise TypeError(f"Analog Output comment must be a string, received {type(value).__name__}.")

        if len(value) > 24:
            raise ValueError(f"Analog Output comment cannot exceed 24 characters. Received {len(value)} characters.")

        if "|" in value:
            raise ValueError("Analog Output comment cannot contain the reserved protocol separator '|'.")

        self._robot._request(236, index, value)


class AnalogOutputs:
    """Provides indexed read and write access to FANUC Analog Outputs."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = AnalogOutputComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)

        received_value = self._robot._request(233, index)

        try:
            return int(received_value)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid Analog Output response. Expected an integer, received '{received_value}'.") from error

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, int) or isinstance(value, bool):
            raise TypeError(f"Analog Output value must be an integer, received {type(value).__name__}.")

        if not 0 <= value <= 65535:
            raise ValueError(f"Analog Output value must be between 0 and 65535, received {value}.")

        self._robot._request(234, index, value)
