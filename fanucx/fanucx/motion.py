from .exceptions import RobotProtocolError

from .position_protocol import (
    _parse_cartesian_position,
    _parse_joint_position,
    _serialize_cartesian_position,
    _serialize_joint_position,
)

from .positions import (
    CartesianPosition,
    JointPosition,
)

from .validation import _validate_register_index

def _validate_frame_number(frame_number):
    if not isinstance(frame_number, int) or isinstance(frame_number, bool):
        raise TypeError(f"Frame number must be an integer, received {type(frame_number).__name__}")

    if frame_number < 0:
        raise ValueError(f"Frame number must be greater than or equal to zero, received {frame_number}")

def _parse_current_cartesian_position(response_arguments):
    position_fields = response_arguments.split(";")

    if len(position_fields) != 7:
        raise RobotProtocolError(f"Invalid current Cartesian position format. Expected 7 fields, received {len(position_fields)}")

    return _parse_cartesian_position(response_arguments)

def _parse_current_joint_position(response_arguments):
    position_fields = response_arguments.split(";")

    if len(position_fields) != 6:
        raise RobotProtocolError(f"Invalid current Joint position format. Expected 6 axes, received {len(position_fields)}")

    return _parse_joint_position(response_arguments)

def _serialize_cartesian_target(target):
    if not isinstance(target, CartesianPosition):
        raise TypeError(f"Target must be a CartesianPosition, received {type(target).__name__}")

    if len(target.extended_axes) > 0:
        raise ValueError(f"Reachability target cannot contain extended axes. Received {len(target.extended_axes)} extended axes")

    return _serialize_cartesian_position(target) 

def _parse_reachability(response_arguments):
    result_fields = response_arguments.split(";")

    if len(result_fields) != 2:
        raise RobotProtocolError(f"Invalid reachability response. Expected 2 fields, received {len(result_fields)}")

    accepted_text, status_text = result_fields

    if accepted_text not in ("0", "1"):
        raise RobotProtocolError(f"Invalid reachability response. Expected result '0' or '1', received {accepted_text!r}")

    try:
        check_status = int(status_text)

    except ValueError as error:
        raise RobotProtocolError(f"Invalid reachability response. CHECK_EPOS status must be an integer, received {type(status_text).__name__}") from error

    accepted = accepted_text == "1"

    if accepted and check_status != 0:
        raise RobotProtocolError(f"Invalid reachability response. An accepted position must have status 0, received {check_status}")

    if not accepted and check_status == 0:
        raise RobotProtocolError("Invalid reachability response. A rejected position must have a nonzero CHECK_EPOS status")

    return accepted

def _serialize_motion_target(target):
    if isinstance(target, CartesianPosition):
        if target.extended_axes:
            raise ValueError(f"Motion target cannot contain extended axes. Received {len(target.extended_axes)} extended axes")

        return 2, _serialize_cartesian_position(target)

    if isinstance(target, JointPosition):
        if len(target.axes) != 6:
            raise ValueError(f"Motion target must contain exactly 6 axes, received {len(target.axes)}")

        return 9, _serialize_joint_position(target)

    raise TypeError(f"Motion target must be a CartesianPosition or JointPosition, received {type(target).__name__}")

def _parse_motion_status(response_arguments):
    motion_status_fields = response_arguments.split(";")

    if len(motion_status_fields) != 5:
        raise RobotProtocolError(f"Invalid motion status format. Expected 5 fields, received {len(motion_status_fields)}")

    try:
        motion_status_values = tuple(int(field) for field in motion_status_fields)

    except ValueError as error:
        raise RobotProtocolError(f"Invalid motion status format. All fields must be integers. Received fields: {motion_status_fields}") from error

    return motion_status_values

def _serialize_termination(termination):
    if termination == "FINE":
        return -1

    if not isinstance(termination, int) or isinstance(termination, bool):
        raise TypeError(f"Motion termination must be 'FINE' or an integer from 0 to 100, received {type(termination).__name__}")

    if termination < 0 or termination > 100:
        raise ValueError(f"Motion termination must be between 0 and 100, received {termination}")

    return termination

def _validate_joint_speed(speed):
    if not isinstance(speed, int) or isinstance(speed, bool):
        raise TypeError(f"Joint motion speed must be an integer, received {type(speed).__name__}")

    if speed < 1 or speed > 100:
        raise ValueError(f"Joint motion speed must be between 1 and 100, received {speed}")

def _validate_linear_speed(speed):
    if not isinstance(speed, int) or isinstance(speed, bool):
        raise TypeError(f"Linear motion speed must be an integer, received {type(speed).__name__}")

    if speed <= 0:
        raise ValueError(f"Linear motion speed must be greater than zero, received {speed}")
        
     
class Motion:
    """Provides current-position and reachability operations."""

    def __init__(self, robot):
        self._robot = robot

    def cartesian(self, group=1):
        _validate_register_index(group)

        response_arguments = self._robot._request(700, group)

        return _parse_current_cartesian_position(response_arguments)

    def joints(self, group=1):
        _validate_register_index(group)

        response_arguments = self._robot._request(701, group)

        return _parse_current_joint_position(response_arguments)

    def is_reachable(self, target, group=1, uframe=0, utool=0):
        _validate_register_index(group)
        _validate_frame_number(uframe)
        _validate_frame_number(utool)

        serialized_target = _serialize_cartesian_target(target)
        response_arguments = self._robot._request(702, group, uframe, utool, serialized_target)

        return _parse_reachability(response_arguments)

    def status(self):
        response_arguments = self._robot._request(720)
        return _parse_motion_status(response_arguments)

    def movej(self, target, speed=100, termination="FINE", group=1, uframe=0, utool=0):
        _validate_register_index(group)
        _validate_frame_number(uframe)
        _validate_frame_number(utool)
        _validate_joint_speed(speed)

        if group != 1:
            raise ValueError(f"Joint motion supports Motion Group 1, received {group}.")

        serialized_termination = _serialize_termination(termination)
        position_type, serialized_target = _serialize_motion_target(target)

        self._robot._request(
            710,
            group,
            uframe,
            utool,
            speed,
            serialized_termination,
            position_type,
            serialized_target,
        )

        motion_status = self.status()

        while motion_status[2] in (1, 2):
            motion_status = self.status()

        return motion_status

    def movel(self, target, speed=2000, termination="FINE", group=1, uframe=0, utool=0):
        _validate_register_index(group)
        _validate_frame_number(uframe)
        _validate_frame_number(utool)
        _validate_linear_speed(speed)

        if group != 1:
            raise ValueError(f"Linear motion supports Motion Group 1, received {group}.")

        serialized_termination = _serialize_termination(termination)
        position_type, serialized_target = _serialize_motion_target(target)

        self._robot._request(
            711,
            group,
            uframe,
            utool,
            speed,
            serialized_termination,
            position_type,
            serialized_target,
        )

        motion_status = self.status()

        while motion_status[2] in (1, 2):
            motion_status = self.status()

        return motion_status

    def abort_motion(self):
        self._robot._request(721)
        return self.status()