# Python-FANUC Smart Gateway

A FANUC RoboGuide project that allows a Python application to communicate with a virtual FANUC robot using TCP sockets

The project combines Python, FANUC KAREL, TP programs and Socket Messaging to create a parameter-driven glue application process with process monitoring, recovery handling and CSV traceability.

## Table of Contents
- Description
- Features
- Communication Protocol
- Process Results
- Limitations
- License

## Description
Python-FANUC Smart Gateway is a simulation project developed in FANUC RoboGuide.

The project demonstrates how external software can communicate with a virtual FANUC robot using a custom TCP communication protocol.

Python acts as a basic operator interface and TCP client. FANUC KAREL acts as a communication gateway and socket server. TP programs handle robot motion, process execution, glue application monitoring and process evaluation.

The application supports two simulated products (left & right door) and two glue application tools are available (glue gun green & glue gun blue)

Each product and tool combination uses a dedicated robot trajectory.

The process speed is selected through the Python interface and transferred to the FANUC controller before process execution.

The project was designed as a proof of concept for learning and demonstrating:

- Python socket communication
- FANUC KAREL programming
- FANUC TP process programming
- Parameter-driven robot execution
- Process monitoring
- Fault recovery
- Process parameters simulation
- Basic production traceability

## Features
 
The application is divided into three main layers: the Python client, the KAREL communication gateway and the TP process programs.
 
### Python Client
 
The Python application provides a console-based operator interface.
Available actions:
```
1 = GET_STATUS
2 = RUN_PROCESS
3 = GET_PROCESS_RESULT
4 = ROBOT_RECOVERY
X = EXIT
```

The Python client also provides:

- Automatic command ID generation
- Operator input validation
- Connection timeout and error handling
- Dynamic robot response parsing
- Continuous operation through a console menu
- Date and time generation
- Process result logging to CSV

The Python client communicates with the RoboGuide virtual controller using a TCP socket.
Default connection settings:
 
```python
HOST = "127.0.0.1"
PORT = 12345
TIMEOUT_SECONDS = 5
```
- `HOST` defines the IP address of the computer running the RoboGuide virtual controller.
- `PORT` must match the server port configured in the KAREL gateway.
- `TIMEOUT_SECONDS` defines how long the client waits for a connection or robot response.

The current configuration uses `127.0.0.1` because the Python client and RoboGuide are running on the same computer.

Each command uses a separate TCP connection:

```
Build request
Connect to server
Send request
Receive response
Close connection
```
 
The Python client uses only standard Python libraries, so no additional packages are required.

### KAREL Gateway

The `GATEWAY_SERVER` program acts as the communication bridge between the Python client and the FANUC TP programs.

The KAREL gateway works as a TCP socket server and listens for requests sent by the Python application.

Its main responsibilities include:

- Opening and managing the socket connection
- Receiving requests from the Python client
- Parsing semicolon-separated `KEY=VALUE` fields
- Identifying the requested action
- Reading the current robot status
- Validating process parameters
- Mapping product, tool and speed values to FANUC registers
- Setting request flags for the TP programs
- Reading process results and FANUC alarm messages
- Building structured responses for the Python client

The gateway supports the following actions:

```text
GET_STATUS
RUN_PROCESS
GET_PROCESS_RESULT
ROBOT_RECOVERY
```
The request dispatcher uses the `ACTION` field to select the correct operation.

The response_sent flag ensures that only one response is sent for each client request.

The server uses the following connection settings:

SERVER TAG = S3

PORT = 12345

Each request is handled through a separate TCP connection. After sending the response, the KAREL program closes the connection and waits for the next client request.

### TP Process Layer
 
The TP process layer is responsible for robot motion, glue application and process execution.
 
The main TP programs include:
 
- `MAIN`: Runs the main control loop, calls the KAREL gateway and handles process and recovery requests.
- `INIT_VAR`: Resets process flags, result codes and process parameters during application startup.
- `CYCLE`: Measures the cycle time, selects the requested product process and starts the final process evaluation.
- `LEFT_DOOR_GLUING`: Executes the left door gluing trajectories for both available glue guns.
- `RIGHT_DOOR_GLUING`: Executes the right door gluing trajectories for both available glue guns.
- `PROCESS_EVALUATION`: Evaluates process completion, cycle time and glue flow deviations.
- `HOME`: Returns the robot to the defined HOME position.
- `GLUE_FLOW_GENERATOR`: Runs as Background Logic and generates simulated glue flow values during glue application.
 
The process is controlled using FANUC registers and flags populated by the KAREL gateway.
 
The selected process recipe includes:
 
- Product
- Glue application tool
- Process speed
 
Four process variants are supported:
 
```text
LEFT_DOOR + TOOL_1
LEFT_DOOR + TOOL_2
RIGHT_DOOR + TOOL_1
RIGHT_DOOR + TOOL_2
```
Each product and tool combination uses a dedicated robot trajectory because the glue guns use different UTOOL definitions and require different taught positions.

During process execution, the TP programs:

- Reset the process status flags.
- Load the required UFRAME, UTOOL and payload.
- Move the robot to the approach position.
- Start glue application.
- Execute the selected gluing trajectory.
- Monitor the glue application signal.
- Stop glue application.
- Move the robot to the exit and HOME positions.
- Store the measured cycle time.
- Evaluate the final process result.

If glue application is lost during robot motion, the TP program interrupts the trajectory and performs a controlled vertical retraction from the current robot position.

### Process Monitoring
 
The application monitors robot readiness and process quality during the simulated glue application cycle.
 
#### Robot Zone Monitoring
 
The current robot zone is detected using FANUC Space Check outputs.
 
Available robot zones:
 
```text
SAFE
WORKING
RESTRICTED
UNKNOWN
```
 
The detection priority is:
 
```text
RESTRICTED
WORKING
SAFE
UNKNOWN
```
 
A process request can only be accepted when:
 
- The robot is in the `SAFE` zone
- System Ready is ON
- FANUC Fault is OFF
- All process parameters are valid
 
#### Glue Application Monitoring
 
The glue application signal is monitored during each gluing trajectory:
 
```text
DO[10:GLUE_APPLICATION]
```
 
The TP programs use `SKIP CONDITION` to detect the loss of glue application during robot motion.
 
If the signal changes to OFF during a monitored movement:
 
1. The current trajectory is interrupted.
2. The glue application loss flag is set.
3. The current robot position is stored.
4. The recovery position is shifted vertically by 100 mm.
5. The robot retracts safely from the workpiece.
6. The gluing process is terminated.
7. The final process result is evaluated as NOK.
 
The recovery position is stored in:
 
```text
PR[2:WRKZONE_RECOVERY]
```
 
The glue application loss flag is:
 
```text
F[3:GLUE_APPLICATION_LOST]
```
#### Glue Flow Simulation
 
A FANUC Background Logic program simulates a live glue flow value while glue application is active.
 
The simulated value is generated using the changing value of the FANUC `$FAST_CLOCK` system variable and the modulo operation.
 
General formula:
 
```text
VALUE = (CHANGING_VALUE MOD (MAX - MIN + 1)) + MIN
```
 
The simulated glue flow is periodically updated and stored in:
 
```text
R[8:ACTUAL_GLUE_FLOW]
```
 
The last update time is stored in:
 
```text
R[9:LAST_FLOW_UPDATE]
```
 
The generated value is compared with the defined process tolerance limits.
 
If the value is outside the allowed range, one of the following flags is set:
 
```text
F[5:GLUE_FLOW_BELOW_TOL]
F[6:GLUE_FLOW_ABOVE_TOL]
```
 
The flags block each other, so only the first detected glue flow deviation is recorded during a process cycle.
 
The glue flow generator is intended only for simulation and demonstration purposes. It does not represent information received from a physical flow meter.
 
#### Cycle Time Monitoring
 
The process cycle time is measured using a FANUC timer and stored in:
 
```text
R[1:GLUE_CYCLE_TIME]
```
 
The measured time is compared with the configured limits:
 
```text
R[2:CYCLE_TIME_MIN]
R[3:CYCLE_TIME_MAX]
```
 
A cycle completed outside the allowed time range is evaluated as NOK.

### CSV Traceability

The Python client provides basic process traceability by saving process results to a CSV file.

CSV logging is performed only after receiving a `GET_PROCESS_RESULT` response.

Python adds the current date and time to the robot response and appends the complete process record to:

```text
process_results.csv
```

The CSV report contains the following fields:

- `CMD_ID`: Unique command identifier
- `ACTION`: Requested robot action
- `PRODUCT`: Processed product
- `RESULT`: Final process result
- `TOOL`: Selected glue application tool
- `TIME`: Measured process cycle time
- `V`: Selected process speed
- `MESSAGE`: Process result or deviation reason
- `DATE`: Report date generated by Python
- `HOUR`: Report time generated by Python

If the CSV file does not exist, the Python client creates it and writes the column headers. If the file already exists, each new process result is appended as a separate row.

An example CSV report is included in the repository:

```text
examples/process_results_example.csv
```

The example file contains representative `OK` and `NOK` results generated during RoboGuide testing.

## Communication Protocol

The Python client and the KAREL gateway exchange text messages using a custom communication protocol.

Each message contains semicolon-separated `KEY=VALUE` fields.

Example:

```text
CMD_ID=CMD_0001;ACTION=GET_STATUS
```

Every request contains:

- `CMD_ID`: Unique command identifier generated by Python
- `ACTION`: Operation requested by the Python client

The following actions are supported:

```text
GET_STATUS
RUN_PROCESS
GET_PROCESS_RESULT
ROBOT_RECOVERY
```

Each request uses a separate TCP connection:

```text
Python builds the request
Python connects to the KAREL server
Python sends the request
KAREL processes the requested action
KAREL sends one response
Python receives the response
The TCP connection is closed
```

### GET_STATUS

The `GET_STATUS` action reads the current robot status and checks whether the robot is ready for process execution.

Request:

```text
CMD_ID=CMD_0001;ACTION=GET_STATUS
```

Example response:

```text
CMD_ID=CMD_0001;ACTION=GET_STATUS;STATUS=OK;ZONE=SAFE;TOOL=TOOL_2;FAULT=OFF;MESSAGE=PROCESS_READY
```

The response contains:

- `STATUS`: Robot readiness status
- `ZONE`: Current robot zone
- `TOOL`: Active FANUC user tool
- `FAULT`: Current FANUC fault state
- `MESSAGE`: Current robot status message

The robot status is `OK` only when:

- The robot is in the `SAFE` zone
- System Ready is ON
- FANUC Fault is OFF

Any other condition returns:

```text
STATUS=NOK
```

### RUN_PROCESS

The `RUN_PROCESS` action validates the selected process parameters and requests process execution.

Request:

```text
CMD_ID=CMD_0002;ACTION=RUN_PROCESS;PRODUCT=LEFT_DOOR;TOOL=TOOL_2;SPEED=500
```

Required process parameters:

- `PRODUCT`: Selected product
- `TOOL`: Selected glue application tool
- `SPEED`: Selected process speed in millimetres per second

Supported products:

```text
LEFT_DOOR
RIGHT_DOOR
```

Supported tools:

```text
TOOL_1
TOOL_2
```

The process speed must be greater than zero.

Accepted response:

```text
CMD_ID=CMD_0002;ACTION=RUN_PROCESS;COMMAND_STATUS=ACCEPTED;MESSAGE=PROCESS_READY
```

Rejected response:

```text
CMD_ID=CMD_0002;ACTION=RUN_PROCESS;COMMAND_STATUS=REJECTED;MESSAGE=INVALID_PROCESS_PARAMETERS
```

The command is accepted only when:

- The robot status is `OK`
- The robot is in the `SAFE` zone
- FANUC Fault is OFF
- The selected product is valid
- The selected tool is valid
- The selected speed is valid

When the request is accepted, KAREL maps the process parameters to FANUC registers and sets the process request flag.

### GET_PROCESS_RESULT

The `GET_PROCESS_RESULT` action reads the result and parameters of the latest process.

Request:

```text
CMD_ID=CMD_0003;ACTION=GET_PROCESS_RESULT
```

Example response:

```text
CMD_ID=CMD_0003;ACTION=GET_PROCESS_RESULT;PRODUCT=LEFT_DOOR;RESULT=OK;TOOL=2;TIME=7.380;V=500;MESSAGE=NONE
```

The response contains:

- `PRODUCT`: Processed product
- `RESULT`: Final process result, `OK` or `NOK`
- `TOOL`: Selected glue application tool number
- `TIME`: Measured process cycle time
- `V`: Selected process speed
- `MESSAGE`: Final process result or deviation reason

Possible process messages include:

```text
NONE
PROCESS_NOT_EVALUATED
GLUE_APPLICATION_LOST
CYCLE_TIME_TOO_LOW
CYCLE_TIME_TOO_HIGH
GLUE_FLOW_TOO_LOW
GLUE_FLOW_TOO_HIGH
```

If the process has not yet been evaluated, the response contains:

```text
RESULT=NOK;MESSAGE=PROCESS_NOT_EVALUATED
```

After receiving the response, Python adds the current date and time and saves the complete process record to the CSV report.

### ROBOT_RECOVERY

The `ROBOT_RECOVERY` action requests a controlled return of the robot to the defined HOME position.

Request:

```text
CMD_ID=CMD_0004;ACTION=ROBOT_RECOVERY
```

Accepted response:

```text
CMD_ID=CMD_0004;ACTION=ROBOT_RECOVERY;COMMAND_STATUS=ACCEPTED;MESSAGE=NONE
```

Rejected response:

```text
CMD_ID=CMD_0004;ACTION=ROBOT_RECOVERY;COMMAND_STATUS=REJECTED;MESSAGE=<FANUC_ALARM>
```

When the request is accepted:

1. KAREL sets the recovery request flag.
2. The MAIN TP program detects the flag.
3. The HOME TP program is called.
4. The request flag is reset after the recovery program is completed.

The `ACCEPTED` response confirms that the recovery request was accepted. It does not confirm that the robot has already reached the HOME position.

The recovery request is rejected when a FANUC fault is active.

### Unknown Action

If Python sends an unsupported action, the KAREL gateway returns:

```text
CMD_ID=CMD_0005;ACTION=UNKNOWN;STATUS=NOK;FAULT=OFF;MESSAGE=UNKNOWN_COMMAND
```

The returned `CMD_ID` allows the Python client to connect the error response with the original request.

## Process Results

The final process result is evaluated by the `PROCESS_EVALUATION` TP program after the gluing cycle is completed or interrupted.

The general result is stored in:

```text
R[4:PROCESS_RESULT]
```

Possible values:

```text
1 = OK
2 = NOK
```

A detailed result code is stored in:

```text
R[5:RESULT_CODE]
```

Available result codes:

```text
0 = NOT_EVALUATED
1 = PROCESS_OK
2 = GLUE_APPLICATION_LOST
3 = CYCLE_TIME_TOO_LOW
4 = CYCLE_TIME_TOO_HIGH
5 = GLUE_FLOW_TOO_LOW
6 = GLUE_FLOW_TOO_HIGH
```

For a completed process, the result is evaluated using the following priority:

```text
1. GLUE_FLOW_TOO_LOW
2. GLUE_FLOW_TOO_HIGH
3. CYCLE_TIME_TOO_LOW
4. CYCLE_TIME_TOO_HIGH
5. PROCESS_OK
```

If the process is interrupted because the glue application signal is lost, the result is set to:

```text
RESULT=NOK
MESSAGE=GLUE_APPLICATION_LOST
```

Only one final result code is assigned to each process cycle.

Process deviations are also reported using FANUC User Alarms:

```text
UALM[1] = GLUE_APPLICATION_LOST
UALM[2] = CYCLE_TIME_TOO_LOW
UALM[3] = CYCLE_TIME_TOO_HIGH
UALM[4] = GLUE_FLOW_TOO_LOW
UALM[5] = GLUE_FLOW_TOO_HIGH
```

The final result can be requested from Python using the `GET_PROCESS_RESULT` action and saved to the CSV report.

## Limitations

Current limitations include:

- The project was developed and tested in RoboGuide.
- The communication protocol is limited by KAREL STRING[128].
- One TCP connection is used for each command.
- The Python client sends protocol fields in a predefined format.
- The KAREL parser is designed for requests generated by the included Python client.
- Glue flow values are simulated.
- Glue flow values are not received from a physical flow meter.
- $FAST_CLOCK provides pseudorandom simulation values.
- Process data is stored in standard FANUC registers and flags.
- ROBOT_RECOVERY=ACCEPTED confirms request acceptance, not recovery completion.
- The CSV report provides basic traceability and is not a production database.
- The project does not replace robot, machine or cell safety systems.

## License
This project is available under an open-source license. Everyone is free to use, modify and develop the project further in accordance with the selected license.

The project was written using RoboGuide ver. 9 rev. ZH. Warning: Always test the project virtually before uploading it to a robot. Do not run it immediately in automatic mode on a real robot. It is recommended to use T1 or T2 mode first

Contributions, technical feedback and suggestions for further development are welcome.
