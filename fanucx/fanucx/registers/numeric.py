from ..validation import _validate_register_index


class NumericRegisterComments:
    """Provides indexed read and write access to numeric register comments."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, index):
        _validate_register_index(index)
        return self._robot._request(102, index)

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, str):
            raise TypeError(f"Numeric register comment must be a string, received {type(value).__name__}")

        if len(value) > 16:
            raise ValueError(f"Numeric register comment cannot exceed 16 characters. Received {len(value)} characters")

        if "|" in value:
            raise ValueError("Numeric register comment cannot contain the reserved protocol separator '|'")
                
        self._robot._request(103, index, value)


class NumericRegisters:
    """Provides indexed access to FANUC numeric register values and comments."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = NumericRegisterComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)
        received_value = self._robot._request(100, index).strip()

        try:
            return int(received_value)
        except ValueError:
            return float(received_value)

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if (not isinstance(value, (int, float)) or isinstance(value, bool)):
            raise TypeError(f"Numeric Register value must be an integer or float, received {type(value).__name__}.")
        
        self._robot._request(101, index, value)