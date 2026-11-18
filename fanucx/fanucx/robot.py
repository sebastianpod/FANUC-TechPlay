"""Core robot connection and public FanucX API"""


import socket

from .variables import Variables

from .alarms import Alarms

from .exceptions import (
    RobotCommunicationError,
    RobotConnectionError,
    RobotNotConnectedError,
    RobotOperationError,
    RobotProtocolError,
)

from .io import (
    AnalogInputs,
    AnalogOutputs,
    DigitalInputs,
    DigitalOutputs,
    Flags,
    GroupInputs,
    GroupOutputs,
    ReadOnlyBooleanPorts,
    RobotInputs,
    RobotOutputs,
)

from .registers import (
    NumericRegisters,
    PositionRegisters,
    StringRegisters,
)

from .frames import ToolFrames, UserFrames

from .payloads import Payloads

from .motion import Motion


class Robot:
    """Represents a connection to a FANUC robot controller."""

    def __init__(self, host, port, timeout=5):
        self.host = host
        self.port = port
        self.timeout = timeout
        self._socket = None
        
        self.r = NumericRegisters(self)
        self.sr = StringRegisters(self)
        self.pr = PositionRegisters(self)
        
        self.variables = Variables(self)
        self.alarms = Alarms(self)

        self.f = Flags(self)

        self.di = DigitalInputs(self)
        self.do = DigitalOutputs(self)

        self.gi = GroupInputs(self)
        self.go = GroupOutputs(self)

        self.ai = AnalogInputs(self)
        self.ao = AnalogOutputs(self)

        self.ri = RobotInputs(self)
        self.ro = RobotOutputs(self)

        self.ui = ReadOnlyBooleanPorts(self, value_command=250, comment_command=251)
        self.uo = ReadOnlyBooleanPorts(self, value_command=252, comment_command=253)
        self.si = ReadOnlyBooleanPorts(self, value_command=254, comment_command=255)
        self.so = ReadOnlyBooleanPorts(self, value_command=256, comment_command=257)

        self.uframe = UserFrames(self)
        self.utool = ToolFrames(self)

        self.payload = Payloads(self) 

        self._motion = Motion(self) 

    def connect(self):
        """Connect to the FanucX server and validate its handshake"""

        if self._socket is None:
            try:
                self._socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                self._socket.settimeout(self.timeout)
                self._socket.connect((self.host, self.port))
                handshake = self._socket.recv(1024)

                if not handshake:
                    self._close_socket()
                    raise RobotConnectionError(f"Connection to {self.host}:{self.port} was closed before the handshake was received")

                handshake = handshake.decode("utf-8")
                handshake = handshake.strip()

                if handshake != "FANUCX|1|READY":
                    self._close_socket()
                    raise RobotProtocolError(f"Invalid handshake. Expected 'FANUCX|1|READY', received '{handshake}'")
                    
            except ConnectionRefusedError as error:
                self._close_socket()
                raise RobotConnectionError(f"Connection to {self.host}:{self.port} was refused") from error
        
            except TimeoutError as error:
                self._close_socket()
                raise RobotConnectionError(f"Connection to {self.host}:{self.port} timed out after {self.timeout} seconds") from error

            except OSError as error:
                self._close_socket()
                raise RobotConnectionError(f"Could not connect to {self.host}:{self.port}: {error}") from error

    def disconnect(self):
        """Close the active robot connection"""

        self._close_socket()
        
    def _request(self, command_code, *arguments):
        """Send a FanucX request and return its response arguments"""

        if self._socket is None:
            raise RobotNotConnectedError("Robot is not connected. Call connect() first")

        request_fields = []
        request_fields.append(str(command_code))

        for argument in arguments:
            request_fields.append(str(argument))

        request = '|'.join(request_fields) + "\n"

        try:
            self._socket.sendall(request.encode("utf-8"))

            response_buffer = ""

            while "\n" not in response_buffer:
                received_chunk = self._socket.recv(1024)

                if not received_chunk:
                    self._close_socket()
                    raise RobotCommunicationError(f"Connection to {self.host}:{self.port} was closed by the server.")

                response_buffer += received_chunk.decode("utf-8")

        except (TimeoutError, ConnectionResetError, BrokenPipeError) as error:
            self._close_socket()
            raise RobotCommunicationError(f"Communication with {self.host}:{self.port} failed: {error}") from error

        response, _, _ = response_buffer.partition("\n")    

        response_fields = response.split('|')

        if len(response_fields) != 3:
            raise RobotProtocolError(f"Invalid response format. Expected 3 fields, received {len(response_fields)}")

        try:
            response_code = int(response_fields[0])
            operation_status = int(response_fields[1])
        except ValueError as error:
            raise RobotProtocolError("Response code and operation status must be integers") from error
            
        if response_code != command_code:
            raise RobotProtocolError(f"Response code mismatch. Expected {command_code}, received {response_code}")
            
        if operation_status == 0:
            return response_fields[2]
        
        raise RobotOperationError(f"Robot operation failed. Error code: {operation_status}")

    def _close_socket(self):
        """Close and clear the internal socket"""
    
        if self._socket is not None:
            self._socket.close()    
            self._socket = None   

    def cartesian(self, group=1):
        """Return the current Cartesian position for a Motion Group"""
        
        return self._motion.cartesian(group=group)

    def joints(self, group=1):
        """Return the current Joint position for a Motion Group"""

        return self._motion.joints(group=group)

    def is_reachable(self, target, group=1, uframe=0, utool=0):
        """Return whether a Cartesian target is accepted by the controller"""

        return self._motion.is_reachable(target, group=group, uframe=uframe, utool=utool)

    def movej(self, target, speed=100, termination="FINE", group=1, uframe=0, utool=0):
        """Execute a Joint motion and return its final state"""

        return self._motion.movej(target, speed=speed, termination=termination, group=group, uframe=uframe, utool=utool)

    def movel(self, target, speed=2000, termination="FINE", group=1, uframe=0, utool=0):
        """Execute a Linear motion and return its final state"""

        return self._motion.movel(target, speed=speed, termination=termination, group=group, uframe=uframe, utool=utool)

    def abort_motion(self):
        """Abort the active FanucX motion and return its final state"""

        return self._motion.abort_motion()

  

    