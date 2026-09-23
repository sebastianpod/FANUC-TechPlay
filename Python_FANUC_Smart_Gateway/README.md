# Python-FANUC Smart Gateway

A FANUC RoboGuide project that allows a Python application to communicate with a virtual FANUC robot using TCP sockets

The project combines Python, FANUC KAREL, TP programs and Socket Messaging to create a parameter-driven glue application process with process monitoring, recovery handling and CSV traceability.

## Table of Contents
- Description
- System architecture
- Features
- communication-protocol
#process-monitoring
#process-results
#csv-reporting
#project-structure
#limitations
#safety-notice
#license

## Description
Python-FANUC Smart Gateway is a simulation project developed in FANUC RoboGuide.

The project demonstrates how external software can communicate with a virtual FANUC robot using a custom TCP communication protocol.

Python acts as a basic operator interface and TCP client. FANUC KAREL acts as a communication gateway and socket server. TP programs handle robot motion, process execution, glue application monitoring and process evaluation.

The application supports two simulated products:

LEFT_DOOR
RIGHT_DOOR
Two glue application tools are available:

TOOL_1: Green glue gun
TOOL_2: Blue glue gun
Each product and tool combination uses a dedicated robot trajectory.

The process speed is selected through the Python interface and transferred to the FANUC controller before process execution.

The project was designed as a proof of concept for learning and demonstrating:

Python socket communication
FANUC KAREL programming
FANUC TP process programming
Parameter-driven robot execution
Process monitoring
Fault recovery
Glue flow simulation
Basic production traceability
System Architecture
Python Operator Interface
        |
        | TCP Socket
        v
GATEWAY_SERVER.KL
        |
        | Validation and mapping
        v
FANUC Registers and Flags
        |
        v
MAIN.TP
        |
        v
CYCLE.TP
        |
        +--> LEFT_DOOR_GLUING.TP
        |
        +--> RIGHT_DOOR_GLUING.TP
        |
        v
PROCESS_EVALUATION.TP
        |
        v
GET_PROCESS_RESULT
        |
        v
Python CSV Report
The communication model uses the following sequence:

One command
One TCP connection
One robot response
Connection closed
Features
Python Client
The Python application provides a console-based operator interface.

Available actions:

1 = GET_STATUS
2 = RUN_PROCESS
3 = GET_PROCESS_RESULT
4 = ROBOT_RECOVERY
X = EXIT
For RUN_PROCESS, the operator can select:

Product
Glue gun
Process speed
The Python client also provides:

Automatic command ID generation
Operator input validation
Connection timeout handling
Connection error handling
Dynamic robot response parsing
Date and time generation
Process result logging to CSV
Continuous operation through a console menu
Command identifiers use the following format:

CMD_0001
CMD_0002
CMD_0003
KAREL Gateway
GATEWAY_SERVER.KL acts as the communication gateway between Python and the FANUC robot controller.

Its responsibilities include:

Opening the FANUC socket server
Receiving Python requests
Parsing KEY=VALUE fields
Detecting the requested action
Validating process parameters
Mapping process parameters to robot registers
Reading robot status and system alarms
Building structured responses
Triggering TP process requests
Triggering robot recovery requests
The gateway uses a dispatcher controlled by the ACTION field.

The response_sent flag ensures that only one response is returned for each client request.

TP Process Layer
The TP programs handle:

Main request loop
Initialization of process variables
Product trajectory selection
Tool selection
Glue application
Cycle time measurement
Glue application monitoring
Glue flow simulation
Safe recovery motion
Process result evaluation
Return to the HOME position
Communication Protocol
Messages use semicolon-separated KEY=VALUE fields.

GET_STATUS
Request:

CMD_ID=CMD_0001;ACTION=GET_STATUS
Example response:

CMD_ID=CMD_0001;ACTION=GET_STATUS;STATUS=OK;ZONE=SAFE;TOOL=TOOL_2;FAULT=OFF;MESSAGE=PROCESS_READY
The robot is considered ready when:

The robot is in the SAFE zone
System Ready is ON
FANUC Fault output is OFF
RUN_PROCESS
Request:

CMD_ID=CMD_0002;ACTION=RUN_PROCESS;PRODUCT=LEFT_DOOR;TOOL=TOOL_2;SPEED=500
Accepted response:

CMD_ID=CMD_0002;ACTION=RUN_PROCESS;COMMAND_STATUS=ACCEPTED;MESSAGE=PROCESS_READY
Rejected response:

CMD_ID=CMD_0002;ACTION=RUN_PROCESS;COMMAND_STATUS=REJECTED;MESSAGE=INVALID_PROCESS_PARAMETERS
Supported products:

LEFT_DOOR
RIGHT_DOOR
Supported tools:

TOOL_1
TOOL_2
The process speed must be greater than zero.

GET_PROCESS_RESULT
Request:

CMD_ID=CMD_0003;ACTION=GET_PROCESS_RESULT
Example response:

CMD_ID=CMD_0003;ACTION=GET_PROCESS_RESULT;PRODUCT=LEFT_DOOR;RESULT=OK;TOOL=2;TIME=7.380;V=500;MESSAGE=NONE
Response fields:

CMD_ID: Command identifier
ACTION: Requested action
PRODUCT: Processed product
RESULT: Final process result
TOOL: Selected glue gun
TIME: Measured process cycle time
V: Selected process speed
MESSAGE: Process result description
ROBOT_RECOVERY
Request:

CMD_ID=CMD_0004;ACTION=ROBOT_RECOVERY
Accepted response:

CMD_ID=CMD_0004;ACTION=ROBOT_RECOVERY;COMMAND_STATUS=ACCEPTED;MESSAGE=NONE
The accepted response confirms that the recovery request was accepted.

It does not confirm that the robot has already reached the HOME position.

Process Monitoring
Robot Zone Monitoring
The robot zone is detected using Space Check outputs.

Available zones:

SAFE
WORKING
RESTRICTED
UNKNOWN
Detection priority:

RESTRICTED
WORKING
SAFE
UNKNOWN
A process request can only be accepted when:

Robot zone is SAFE
System Ready is ON
FANUC Fault output is OFF
Product parameters are valid
Tool parameters are valid
Process speed is valid
Parameter Mapping
Validated process parameters are mapped to FANUC registers.

R[10:PRODUCT_ID]
1 = LEFT_DOOR
2 = RIGHT_DOOR
R[11:TOOL_NUM]
1 = TOOL_1
2 = TOOL_2
R[12:PROCESS_SPEED]
Selected process speed
Registers are updated only when the complete parameter set is valid.

This prevents a rejected request from partially overwriting a previously validated process recipe.

Glue Application Monitoring
The glue application signal is monitored during robot motion using FANUC SKIP CONDITION.

The monitored signal is:

DO[10:GLUE_APPLICATION]
If glue application is lost during a trajectory:

The process interruption flag is set.
The current robot position is stored.
The recovery position is shifted vertically.
The robot retracts safely from the workpiece.
The gluing trajectory is terminated.
The process is evaluated as NOK.
The recovery position is stored in:

PR[2:WRKZONE_RECOVERY]
The process interruption flag is:

F[3:GLUE_APPLICATION_LOST]
Glue Flow Simulation
A Background Logic program simulates live glue flow while glue application is active.

The simulated value is based on the FANUC $FAST_CLOCK system variable and the modulo operation.

General formula:

VALUE = (CHANGING_VALUE MOD (MAX - MIN + 1)) + MIN
The modulo operation limits the changing clock value to the required number of possible results.

Adding the minimum value shifts the generated range so that it begins at the selected lower limit instead of zero.

The simulated glue flow is periodically updated and stored in:

R[8:ACTUAL_GLUE_FLOW]
The last update time is stored in:

R[9:LAST_FLOW_UPDATE]
The simulated flow is monitored only while glue application is active.

The first detected deviation sets one of the following flags:

F[5:GLUE_FLOW_BELOW_TOL]
F[6:GLUE_FLOW_ABOVE_TOL]
Only one glue flow fault flag can be active during a process cycle.

The glue flow generator is intended only for demonstration purposes. It does not represent data from a physical glue flow meter.

Process Results
Process results are stored in FANUC registers.

Process Result
R[4:PROCESS_RESULT]
1 = OK
2 = NOK
Result Code
R[5:RESULT_CODE]

0 = NOT_EVALUATED
1 = PROCESS_OK
2 = GLUE_APPLICATION_LOST
3 = CYCLE_TIME_TOO_LOW
4 = CYCLE_TIME_TOO_HIGH
5 = GLUE_FLOW_TOO_LOW
6 = GLUE_FLOW_TOO_HIGH
Process evaluation uses a defined priority order.

For a completed process:

1. GLUE_FLOW_TOO_LOW
2. GLUE_FLOW_TOO_HIGH
3. CYCLE_TIME_TOO_LOW
4. CYCLE_TIME_TOO_HIGH
5. PROCESS_OK
For an interrupted process:

GLUE_APPLICATION_LOST
The evaluation logic ensures that only one final result code and one process User Alarm are generated.

CSV Reporting
Every GET_PROCESS_RESULT response is extended by Python with:

Report date
Report time
The result is appended to:

process_results.csv
CSV columns:

CMD_ID
ACTION
PRODUCT
RESULT
TOOL
TIME
V
MESSAGE
DATE
HOUR
An example report is included in the repository:

examples/process_results_example.csv
The example file contains representative OK and NOK process results generated during RoboGuide testing.

The runtime process_results.csv file can be excluded from version control using .gitignore.

Project Structure
Python-FANUC-Smart-Gateway/
|
|-- README.md
|-- LICENSE
|-- .gitignore
|
|-- python/
|   `-- fanuc_client.py
|
|-- karel/
|   `-- gateway_server.kl
|
|-- tp/
|   |-- MAIN.LS
|   |-- INIT_VAR.LS
|   |-- CYCLE.LS
|   |-- LEFT_DOOR_GLUING.LS
|   |-- RIGHT_DOOR_GLUING.LS
|   |-- PROCESS_EVALUATION.LS
|   |-- HOME.LS
|   `-- GLUE_FLOW_GENERATOR.LS
|
`-- examples/
    `-- process_results_example.csv
The final repository structure may differ slightly depending on the exported RoboGuide program names.

socket
csv
os
time
datetime
No additional Python packages are required.

The Python client and RoboGuide virtual controller must be configured to use the same host and TCP port.

Default Python configuration:

HOST = "127.0.0.1"
PORT = 12345
TIMEOUT_SECONDS = 5
Default KAREL server port:

12345
Running the Project
Open the virtual robot project in FANUC RoboGuide.
Verify the socket server configuration.
Verify that server tag S3 uses the expected TCP port.
Verify all required registers, flags and digital outputs.
Start the MAIN TP program.
Run the Python client.
Select an action from the console menu.
Use GET_STATUS to verify robot readiness.
Use RUN_PROCESS to send a process recipe.
Use GET_PROCESS_RESULT after process completion.
Review the generated CSV report.
Example Python menu:

SELECT ACTION:
1 = GET_STATUS
2 = RUN_PROCESS
3 = GET_PROCESS_RESULT
4 = ROBOT_RECOVERY
X = EXIT
Limitations
This project is a proof of concept created for simulation, learning and demonstration purposes.

Current limitations include:

The project was developed and tested in RoboGuide.
The communication protocol is limited by KAREL STRING[128].
One TCP connection is used for each command.
The Python client sends protocol fields in a predefined format.
The KAREL parser is designed for requests generated by the included Python client.
Glue flow values are simulated.
Glue flow values are not received from a physical flow meter.
$FAST_CLOCK provides pseudorandom simulation values.
Process data is stored in standard FANUC registers and flags.
ROBOT_RECOVERY=ACCEPTED confirms request acceptance, not recovery completion.
The CSV report provides basic traceability and is not a production database.
The project does not replace robot, machine or cell safety systems.
Safety Notice
Always test the project in FANUC RoboGuide before transferring any program to a physical robot.

Do not run the project immediately in automatic mode on a real robot.

When adapting the project to a physical system:

Verify all robot positions.
Verify active UFRAME and UTOOL data.
Verify payload definitions.
Verify Space Check configuration.
Verify recovery trajectories.
Verify all process signals.
Verify all safety signals.
Start testing in T1 mode at reduced speed.
Perform an appropriate risk assessment.
Socket communication, KAREL logic and the Python application must never replace certified robot, machine or cell safety functions.

## License
This project is available under an open-source license.

Everyone is free to use, modify and develop the project further in accordance with the selected license.

FANUC RoboGuide and the required FANUC software options are necessary to run the complete simulation.

Contributions, technical feedback and suggestions for further development are welcome.
