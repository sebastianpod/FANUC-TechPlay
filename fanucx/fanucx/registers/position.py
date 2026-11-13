from ..exceptions import RobotProtocolError
from ..positions import (
    CartesianConfiguration,
    CartesianPosition,
    JointPosition,
)
from ..validation import _validate_register_index


class PositionRegisterComments:
    """Provides indexed read and write access to position register comments."""

    def __init__(self, robot):
        self._robot = robot

    def __getitem__(self, index):
        _validate_register_index(index)
        return self._robot._request(125, index)

    def __setitem__(self, index, value):
        _validate_register_index(index)

        if not isinstance(value, str):
            raise TypeError(f"Position register comment must be a string, received {type(value).__name__}")

        if len(value) > 16:
            raise ValueError(f"Position register comment cannot exceed 16 characters. Received {len(value)} characters")

        if "|" in value:
            raise ValueError("Position register comment cannot contain the reserved protocol separator '|'")
                
        self._robot._request(126, index, value)


class PositionRegisters:
    """Provides indexed access to FANUC position registers."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = PositionRegisterComments(robot)

    def get_cartesian(self, index, group=1):
        _validate_register_index(index)
        _validate_register_index(group)
        request_arguments = f"{index};{group}"
        response_arguments = self._robot._request(121, request_arguments)
        return _parse_cartesian_position(response_arguments)

    def get_joint(self, index, group=1):
        _validate_register_index(index)
        _validate_register_index(group)
        request_arguments = f"{index};{group}"
        response_arguments = self._robot._request(122, request_arguments)
        return _parse_joint_position(response_arguments)

    def get_type(self, index, group=1):
        _validate_register_index(index)
        _validate_register_index(group)
        request_arguments = f"{index};{group}"
        response_arguments = self._robot._request(120, request_arguments)

        position_fields = response_arguments.split(';')

        if len(position_fields) != 2:
            raise RobotProtocolError(f"Invalid Position register type format. Expected 2 fields, received {len(position_fields)}")

        try:
            position_type = int(position_fields[0])
            number_of_axes = int(position_fields[1])

        except ValueError as error:
            raise RobotProtocolError(f"Invalid position register type format. Position type and number of axes must be integers. Received fields: {position_fields}.") from error

        return position_type, number_of_axes

    def __getitem__(self, index):
        position_type, number_of_axes = self.get_type(index)

        if position_type in (2, 6):
            return self.get_cartesian(index)

        if position_type == 9:
            return self.get_joint(index)

        raise RobotProtocolError(f"Unsupported position register type: {position_type}")

    def __setitem__(self, index, position):
        _validate_register_index(index)

        if isinstance(position, CartesianPosition):
            return self.set_cartesian(index, position, group=1)

        if isinstance(position, JointPosition):
            return self.set_joint(index, position, group=1)

        else:
            raise TypeError(f"Expected CartesianPosition or JointPosition, received {type(position).__name__}")


    def set_cartesian(self, index, position, group=1):
        _validate_register_index(index)
        _validate_register_index(group)
        serialized_position = _serialize_cartesian_position(position)
        request_arguments = f"{index};{group};{serialized_position}"
        return self._robot._request(123, request_arguments)

    def set_joint(self, index, position, group=1):
        _validate_register_index(index)
        _validate_register_index(group)
        serialized_position = _serialize_joint_position(position)
        request_arguments = f"{index};{group};{serialized_position}"
        return self._robot._request(124, request_arguments)


def _parse_cartesian_position(response_arguments):
    position_fields = response_arguments.split(';')

    if len(position_fields) < 7 or len(position_fields) > 10:
        raise RobotProtocolError(f"Invalid Cartesian position format. Expected between 7 and 10 fields, received {len(position_fields)}")

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
        raise RobotProtocolError(f"Invalid Cartesian position format. Coordinates and extended axes must be numeric. Received fields: {position_fields}") from error

    configuration = CartesianConfiguration(position_fields[6])

    return CartesianPosition(x=x, y=y, z=z, w=w, p=p, r=r, configuration=configuration, extended_axes=extended_axes)


def _parse_joint_position(response_arguments):
    position_fields = response_arguments.split(';')

    if len(position_fields) < 1 or len(position_fields) > 9:
        raise RobotProtocolError(f"Invalid Joint position format. Expected between 1 and 9 fields, received {len(position_fields)}")

    try:
        axes_list = []
        for value in position_fields:
            axes_list.append(float(value))

        axes = tuple(axes_list)

    except ValueError as error:
        raise RobotProtocolError(f"Invalid Joint position format. All axis values must be numeric. Received fields: {position_fields}") from error

    return JointPosition(axes)


def _serialize_cartesian_position(position):
    if not isinstance(position, CartesianPosition):
        raise TypeError(f"Expected CartesianPosition, received {type(position).__name__}")

    position_fields = [
    str(position.x),
    str(position.y),
    str(position.z),
    str(position.w),
    str(position.p),
    str(position.r),
    position.configuration.value,]

    for extended_axes in position.extended_axes:
        position_fields.append(str(extended_axes))

    return ";".join(position_fields)


def _serialize_joint_position(position):
    if not isinstance(position, JointPosition):
        raise TypeError(f"Expected JointPosition, received {type(position).__name__}.")

    if not (1 <= len(position.axes) <= 9):
        raise ValueError(f"JointPosition must contain between 1 and 9 axes, received {len(position.axes)}.")
    
    axes_list = []

    for axis_value in position.axes:
        axes_list.append(str(axis_value))
        
    serialized_position = ';'.join(axes_list)

    return serialized_position