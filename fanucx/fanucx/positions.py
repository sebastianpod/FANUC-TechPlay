
class JointPosition:
    """Represents a FANUC joint position."""

    def __init__(self, axes):
        self.axes = axes


class CartesianConfiguration:
    """Represents the FANUC configuration associated with a Cartesian position."""

    def __init__(self, value):
        self.value = value


class CartesianPosition:
    def __init__(self, x, y, z, w, p, r, configuration, extended_axes=()):
        self.x = x
        self.y = y
        self.z = z
        self.w = w
        self.p = p
        self.r = r

        if isinstance(configuration, CartesianConfiguration):
            self.configuration = configuration
        elif isinstance(configuration, str):
            self.configuration = CartesianConfiguration(configuration)
        else:
            raise TypeError(f"Expected str or CartesianConfiguration. Received {type(configuration).__name__}")

        self.extended_axes = extended_axes