"""Internal parsing and serialization helpers for FANUC position data"""


from .exceptions import RobotProtocolError

from .positions import (
    CartesianConfiguration,
    CartesianPosition,
    JointPosition,
)

def _serialize_real(value):
    """Serialize a numeric value using protocol-compatible decimal notation"""

    value_text = format(value, ".15f").rstrip("0").rstrip(".")

    if value_text in ("", "-0"):
        return "0"

    return value_text


def _parse_cartesian_position(response_arguments):
    """Parse Cartesian position fields returned by the FanucX server"""

    position_fields = response_arguments.split(";")

    if len(position_fields) < 7 or len(position_fields) > 10:
        raise RobotProtocolError(f"Invalid Cartesian position format. Expected between 7 and 10 fields, received {len(position_fields)}.")

    try:
        x = float(position_fields[0])
        y = float(position_fields[1])
        z = float(position_fields[2])
        w = float(position_fields[3])
        p = float(position_fields[4])
        r = float(position_fields[5])

        extended_axes_list = []

        for value in position_fields[7:]:
            extended_axes_list.append(float(value))

        extended_axes = tuple(extended_axes_list)

    except ValueError as error:
        raise RobotProtocolError(f"Invalid Cartesian position format. Coordinates and extended axes must be numeric. Received fields: {position_fields}.") from error

    configuration = CartesianConfiguration(position_fields[6])

    return CartesianPosition(
        x=x,
        y=y,
        z=z,
        w=w,
        p=p,
        r=r,
        configuration=configuration,
        extended_axes=extended_axes,
    )


def _parse_joint_position(response_arguments):
    """Parse Joint position fields returned by the FanucX server"""

    position_fields = response_arguments.split(";")

    if len(position_fields) < 1 or len(position_fields) > 9:
        raise RobotProtocolError(f"Invalid Joint position format. Expected between 1 and 9 fields, received {len(position_fields)}.")

    try:
        axes_list = []

        for value in position_fields:
            axes_list.append(float(value))

        axes = tuple(axes_list)

    except ValueError as error:
        raise RobotProtocolError(f"Invalid Joint position format. All axis values must be numeric. Received fields: {position_fields}.") from error

    return JointPosition(axes)


def _serialize_cartesian_position(position):
    """Serialize a CartesianPosition for the FanucX protocol"""

    if not isinstance(position, CartesianPosition):
        raise TypeError(f"Expected CartesianPosition, received {type(position).__name__}.")

    position_fields = [
        _serialize_real(position.x),
        _serialize_real(position.y),
        _serialize_real(position.z),
        _serialize_real(position.w),
        _serialize_real(position.p),
        _serialize_real(position.r),
        position.configuration.value,
    ]

    for extended_axis in position.extended_axes:
        position_fields.append(_serialize_real(extended_axis))

    return ";".join(position_fields)


def _serialize_joint_position(position):
    """Serialize a JointPosition for the FanucX protocol"""

    if not isinstance(position, JointPosition):
        raise TypeError(f"Expected JointPosition, received {type(position).__name__}.")

    if not 1 <= len(position.axes) <= 9:
        raise ValueError(f"JointPosition must contain between 1 and 9 axes, received {len(position.axes)}.")

    axes_list = []

    for axis_value in position.axes:
        axes_list.append(_serialize_real(axis_value))

    return ";".join(axes_list)