from .exceptions import RobotProtocolError
from .validation import _validate_register_index


_PAYLOAD_FIELD_COUNT = 7
_PAYLOAD_COMMENT_MAX_LENGTH = 17
_PAYLOAD_INERTIA_SCALE = 980.0


class Payload:
    """Represents a FANUC payload schedule."""

    def __init__(
        self,
        mass,
        center_x,
        center_y,
        center_z,
        inertia_x,
        inertia_y,
        inertia_z,
    ):
        values = {
            "mass": mass,
            "center_x": center_x,
            "center_y": center_y,
            "center_z": center_z,
            "inertia_x": inertia_x,
            "inertia_y": inertia_y,
            "inertia_z": inertia_z,
        }

        for field_name, field_value in values.items():
            if (not isinstance(field_value, (int, float)) or isinstance(field_value, bool)):
                raise TypeError(f"Payload {field_name} must be an integer or float, received {type(field_value).__name__}")

        if mass < 0:
            raise ValueError(f"Payload mass must be greater than or equal to zero, received {mass}")

        if inertia_x < 0:
            raise ValueError(f"Payload inertia_x must be greater than or equal to zero, received {inertia_x}")

        if inertia_y < 0:
            raise ValueError(f"Payload inertia_y must be greater than or equal to zero, received {inertia_y}")

        if inertia_z < 0:
            raise ValueError(f"Payload inertia_z must be greater than or equal to zero, received {inertia_z}")

        self.mass = mass

        self.center_x = center_x
        self.center_y = center_y
        self.center_z = center_z

        self.inertia_x = inertia_x
        self.inertia_y = inertia_y
        self.inertia_z = inertia_z


class PayloadComments:
    """Provides indexed access to FANUC payload comments."""

    def __init__(self, robot):
        self._robot = robot

    def get(self, payload_number, group=1):
        _validate_register_index(payload_number)
        _validate_register_index(group)

        return self._robot._request(622, group, payload_number)

    def set(self, payload_number, comment, group=1):
        _validate_register_index(payload_number)
        _validate_register_index(group)

        if not isinstance(comment, str):
            raise TypeError(f"Payload comment must be a string, received {type(comment).__name__}")

        if len(comment) > _PAYLOAD_COMMENT_MAX_LENGTH:
            raise ValueError(f"Payload comment cannot exceed {_PAYLOAD_COMMENT_MAX_LENGTH} characters. Received {len(comment)} characters")

        if "|" in comment:
            raise ValueError("Payload comment cannot contain the reserved protocol separator '|'")

        self._robot._request(623, group, payload_number, comment)

    def __getitem__(self, payload_number):
        return self.get(payload_number, group=1)

    def __setitem__(self, payload_number, comment):
        self.set(payload_number, comment, group=1)


class Payloads:
    """Provides indexed access to FANUC payload schedules."""

    def __init__(self, robot):
        self._robot = robot
        self.comment = PayloadComments(robot)

    def get(self, payload_number, group=1):
        _validate_register_index(payload_number)
        _validate_register_index(group)

        response_arguments = self._robot._request(620, group, payload_number)

        return _parse_payload(response_arguments)

    def set(self, payload_number, payload, group=1):
        _validate_register_index(payload_number)
        _validate_register_index(group)

        serialized_payload = _serialize_payload(payload)

        self._robot._request(621, group, payload_number, serialized_payload)

    def __getitem__(self, payload_number):
        return self.get(payload_number, group=1)

    def __setitem__(self, payload_number, payload):
        self.set(payload_number, payload, group=1)

    def get_active(self, group=1):
        _validate_register_index(group)

        response_arguments = self._robot._request(624, group)

        try:
            active_payload_number = int(response_arguments)

        except ValueError as error:
            raise RobotProtocolError(f"Invalid active payload response. Expected an integer, received {response_arguments!r}") from error

        if active_payload_number < 0:
            raise RobotProtocolError(f"Active payload number cannot be negative. Received {active_payload_number}")

        return active_payload_number

    def set_active(self, payload_number, group=1):
        _validate_active_payload_number(payload_number)

        _validate_register_index(group)

        self._robot._request(625, group, payload_number)

    @property
    def active(self):
        """Returns the active payload for Motion Group 1."""

        return self.get_active(group=1)

    @active.setter
    def active(self, payload_number):
        """Sets the active payload for Motion Group 1."""

        self.set_active(payload_number, group=1)


def _validate_active_payload_number(payload_number):
    if (not isinstance(payload_number, int) or isinstance(payload_number, bool)):
        raise TypeError(f"Active payload number must be an integer, received {type(payload_number).__name__}")

    if payload_number < 0:
        raise ValueError(f"Active payload number must be greater than or equal to zero, received {payload_number}")


def _parse_payload(response_arguments):
    payload_fields = response_arguments.split(";")

    if len(payload_fields) != _PAYLOAD_FIELD_COUNT:
        raise RobotProtocolError(f"Invalid payload format. Expected {_PAYLOAD_FIELD_COUNT} fields, received {len(payload_fields)}")

    try:
        mass = float(payload_fields[0])

        center_x = float(payload_fields[1])
        center_y = float(payload_fields[2])
        center_z = float(payload_fields[3])

        inertia_x = (float(payload_fields[4]) / _PAYLOAD_INERTIA_SCALE)
        inertia_y = (float(payload_fields[5]) / _PAYLOAD_INERTIA_SCALE)
        inertia_z = (float(payload_fields[6]) / _PAYLOAD_INERTIA_SCALE)

    except ValueError as error:
        raise RobotProtocolError(f"Invalid payload format. All payload values must be numeric. Received fields: {payload_fields}") from error

    try:
        return Payload(
            mass=mass,
            center_x=center_x,
            center_y=center_y,
            center_z=center_z,
            inertia_x=inertia_x,
            inertia_y=inertia_y,
            inertia_z=inertia_z,
        )

    except (TypeError, ValueError) as error:
        raise RobotProtocolError(f"Payload response contains invalid values. Received fields: {payload_fields}") from error


def _serialize_payload(payload):
    if not isinstance(payload, Payload):
        raise TypeError(f"Expected Payload, received {type(payload).__name__}")

    payload_fields = [
        str(payload.mass),
        str(payload.center_x),
        str(payload.center_y),
        str(payload.center_z),
        str(payload.inertia_x * _PAYLOAD_INERTIA_SCALE),
        str(payload.inertia_y * _PAYLOAD_INERTIA_SCALE),
        str(payload.inertia_z * _PAYLOAD_INERTIA_SCALE),
    ]

    return ";".join(payload_fields)