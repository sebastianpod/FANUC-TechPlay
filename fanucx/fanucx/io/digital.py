from ..exceptions import RobotProtocolError
from ..validation import _validate_register_index


class DigitalInputComments:
    """Provides indexed read and write access to FANUC Digital Inputs comments."""
    
    def __init__(self, robot):
        self._robot = robot
    
    def __getitem__(self, index):
        _validate_register_index(index)
    
        return self._robot._request(211, index)
    
    def __setitem__(self, index, value):
        _validate_register_index(index)
    
        if not isinstance(value, str):
            raise TypeError(f"Digital Input comment must be a string, received {type(value).__name__}.")
    
        if len(value) > 24:
            raise ValueError(f"Digital Input comment cannot exceed 24 characters. Received {len(value)} characters")
    
        if "|" in value:
            raise ValueError("Digital Input comment cannot contain the reserved protocol separator '|'")
    
        self._robot._request(212, index, value)


class DigitalInputs:
    """Provides indexed read access to FANUC Digital Inputs."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = DigitalInputComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)

        received_value = self._robot._request(210, index)

        if received_value == "1":
            return True

        if received_value == "0":
            return False

        raise RobotProtocolError(f"Invalid Digital Input response. Expected '0' or '1', received '{received_value}'.")

    
class DigitalOutputComments:
    """Provides indexed read and write access to FANUC Digital Outputs comments."""
    
    def __init__(self, robot):
        self._robot = robot
    
    def __getitem__(self, index):
        _validate_register_index(index)
    
        return self._robot._request(215, index)
    
    def __setitem__(self, index, value):
        _validate_register_index(index)
    
        if not isinstance(value, str):
            raise TypeError(f"Digital Output comment must be a string, received {type(value).__name__}.")
    
        if len(value) > 24:
            raise ValueError(f"Digital Output comment cannot exceed 24 characters. Received {len(value)} characters")
    
        if "|" in value:
            raise ValueError("Digital Output comment cannot contain the reserved protocol separator '|'")
    
        self._robot._request(216, index, value)


class DigitalOutputs:
    """Provides indexed read and write access to FANUC Digital Outputs."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = DigitalOutputComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)

        received_value = self._robot._request(213, index)

        if received_value == "1":
            return True

        if received_value == "0":
            return False

        raise RobotProtocolError(f"Invalid Digital Output response. Expected '0' or '1', received '{received_value}'.")

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, bool):
            raise TypeError(f"Digital output value must be a bool, received {type(value).__name__}.")

        if value:
            protocol_value = 1
        else:
            protocol_value = 0

        self._robot._request(214, index, protocol_value)
