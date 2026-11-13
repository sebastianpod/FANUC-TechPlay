from ..exceptions import RobotProtocolError
from ..validation import _validate_register_index


class RobotInputComments:
    """Provides indexed read and write access to FANUC Robot Inputs comments."""
    
    def __init__(self, robot):
        self._robot = robot
    
    def __getitem__(self, index):
        _validate_register_index(index)
    
        return self._robot._request(241, index)
    
    def __setitem__(self, index, value):
        _validate_register_index(index)
    
        if not isinstance(value, str):
            raise TypeError(f"Robot Input comment must be a string, received {type(value).__name__}.")
    
        if len(value) > 24:
            raise ValueError(f"Robot Input comment cannot exceed 24 characters. Received {len(value)} characters")
    
        if "|" in value:
            raise ValueError("Robot Input comment cannot contain the reserved protocol separator '|'")
    
        self._robot._request(242, index, value)


class RobotInputs:
    """Provides indexed read access to FANUC Robot Inputs."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = RobotInputComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)

        received_value = self._robot._request(240, index)

        if received_value == "1":
            return True

        if received_value == "0":
            return False

        raise RobotProtocolError(f"Invalid Robot Input response. Expected '0' or '1', received '{received_value}'.")


class RobotOutputComments:
    """Provides indexed read and write access to FANUC Robot Outputs comments."""
    
    def __init__(self, robot):
        self._robot = robot
    
    def __getitem__(self, index):
        _validate_register_index(index)
    
        return self._robot._request(245, index)
    
    def __setitem__(self, index, value):
        _validate_register_index(index)
    
        if not isinstance(value, str):
            raise TypeError(f"Robot Output comment must be a string, received {type(value).__name__}.")
    
        if len(value) > 24:
            raise ValueError(f"Robot Output comment cannot exceed 24 characters. Received {len(value)} characters")
    
        if "|" in value:
            raise ValueError("Robot Output comment cannot contain the reserved protocol separator '|'")
    
        self._robot._request(246, index, value)


class RobotOutputs:
    """Provides indexed read and write access to FANUC Robot Outputs."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = RobotOutputComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)

        received_value = self._robot._request(243, index)

        if received_value == "1":
            return True

        if received_value == "0":
            return False

        raise RobotProtocolError(f"Invalid Robot Output response. Expected '0' or '1', received '{received_value}'.")

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, bool):
            raise TypeError(f"Robot output value must be a bool, received {type(value).__name__}.")

        if value:
            protocol_value = 1
        else:
            protocol_value = 0

        self._robot._request(244, index, protocol_value)
