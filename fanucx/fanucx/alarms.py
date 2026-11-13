from dataclasses import dataclass
from enum import IntEnum

from .exceptions import (
    RobotOperationError,
    RobotProtocolError,
)


class AlarmSeverity(IntEnum):
    """Represents the severity of a FANUC alarm history entry."""

    WARNING = 0
    PAUSE = 1
    ABORT = 2


@dataclass(frozen=True)
class Alarm:
    """Represents a FANUC alarm history entry."""

    sequence_number: int
    code: int
    message: str
    cause_code: int
    cause_message: str
    timestamp: str
    severity: AlarmSeverity
    program: str


class Alarms:
    """Provides access to FANUC controller alarm information."""

    _LATEST_ALARM_COMMAND = 500
    _NEXT_ALARM_COMMAND = 501
    _ALARM_FIELD_COUNT = 8

    def __init__(self, robot):
        self._robot = robot

    def _parse_alarm(self, response):
        fields = [
            field.strip()
            for field in response.split("^")
        ]

        if len(fields) != self._ALARM_FIELD_COUNT:
            raise RobotProtocolError(
                "Invalid alarm response. "
                f"Expected {self._ALARM_FIELD_COUNT} fields, "
                f"received {len(fields)}."
            )

        (
            sequence_text,
            code_text,
            message,
            cause_code_text,
            cause_message,
            timestamp,
            severity_text,
            program,
        ) = fields

        try:
            sequence_number = int(sequence_text)
            code = int(code_text)
            cause_code = int(cause_code_text)
            severity_value = int(severity_text)

        except ValueError as error:
            raise RobotProtocolError(
                "Alarm response contains an invalid integer field."
            ) from error

        if sequence_number <= 0:
            raise RobotProtocolError(
                "Alarm response contains an invalid "
                f"sequence number: {sequence_number}."
            )

        try:
            severity = AlarmSeverity(severity_value)

        except ValueError as error:
            raise RobotProtocolError(
                "Alarm response contains an unsupported "
                f"severity value: {severity_value}."
            ) from error

        return Alarm(
            sequence_number=sequence_number,
            code=code,
            message=message,
            cause_code=cause_code,
            cause_message=cause_message,
            timestamp=timestamp,
            severity=severity,
            program=program,
        )

    def latest(self):
        """Returns the most recent alarm history entry."""

        response = self._robot._request(
            self._LATEST_ALARM_COMMAND,
        )

        return self._parse_alarm(response)

    def next_after(self, sequence_number):
        """Returns the first alarm after the supplied sequence number."""

        if (
            not isinstance(sequence_number, int)
            or isinstance(sequence_number, bool)
        ):
            raise TypeError(
                "Alarm sequence number must be an integer, "
                f"received {type(sequence_number).__name__}."
            )

        if sequence_number < 0:
            raise ValueError(
                "Alarm sequence number must be greater than or "
                f"equal to zero, received {sequence_number}."
            )

        response = self._robot._request(
            self._NEXT_ALARM_COMMAND,
            sequence_number,
        )

        return self._parse_alarm(response)

    def oldest(self):
        """Returns the oldest available alarm history entry."""

        return self.next_after(0)

    def history(self, limit=20):
        """Returns alarm history entries from oldest to newest."""

        if not isinstance(limit, int) or isinstance(limit, bool):
            raise TypeError(
                "Alarm history limit must be an integer, "
                f"received {type(limit).__name__}."
            )

        if limit <= 0:
            raise ValueError(
                "Alarm history limit must be greater than zero, "
                f"received {limit}."
            )

        alarms = []
        sequence_number = 0

        for _ in range(limit):
            try:
                alarm = self.next_after(sequence_number)

            except RobotOperationError:
                break

            if alarm.sequence_number <= sequence_number:
                raise RobotProtocolError(
                    "Alarm history sequence did not advance. "
                    f"Previous sequence: {sequence_number}, "
                    f"received: {alarm.sequence_number}."
                )

            alarms.append(alarm)
            sequence_number = alarm.sequence_number

        return alarms