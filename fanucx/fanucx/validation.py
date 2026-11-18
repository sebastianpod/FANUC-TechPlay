"""Internal validation helpers shared by FanucX modules"""


def _validate_register_index(index):
    """Validate a positive integer register index"""

    if not isinstance(index, int) or isinstance(index, bool):
        raise TypeError(f"Register index must be an integer, received {type(index).__name__}.")

    if index <= 0:
        raise ValueError(f"Register index must be greater than zero, received {index}")