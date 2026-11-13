from ..validation import _validate_register_index


class StringRegisterComments:
    """Provides indexed read and write access to string register comments."""
    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, index):
        _validate_register_index(index)
        return self._robot._request(112, index)
    
    def __setitem__(self, index, value):
        _validate_register_index(index)
    
        if not isinstance(value, str):
            raise TypeError(f"String register comment must be a string, received {type(value).__name__}")
    
        if len(value) > 16:
            raise ValueError(f"String register comment cannot exceed 16 characters. Received {len(value)} characters")
    
        if "|" in value:
            raise ValueError("String register comment cannot contain the reserved protocol separator '|'")
                    
        self._robot._request(113, index, value)


class StringRegisters:
    """Provides indexed access to FANUC string register values and comments."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = StringRegisterComments(robot)

    def __getitem__(self, index):
        _validate_register_index(index)
        return self._robot._request(110, index)

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, str):
            raise TypeError(f"String register value must be a string, received {type(value).__name__}")

        if len(value) > 240:
            raise ValueError(f"String register value cannot exceed 240 characters. Received {len(value)} characters")
            
        if '|' in value:
            raise ValueError("String register value cannot contain the reserved protocol separator '|'")

        self._robot._request(111, index, value)