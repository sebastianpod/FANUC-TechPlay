# Project Name: Ariadne

An experimental FANUC RoboGuide project focused on **natural-language robot control**, built on top of a custom communication bridge between a virtual FANUC robot and external software running on the same PC.

## Table of Contents

- Description
- Inspiration for the Name
- Features

## Description

Ariadne is an experimental FANUC RoboGuide project for **natural-language robot control** built on top of a custom **Python ↔ RoboGuide communication bridge**.

The project solves two main problems:

1. **Communication with a virtual FANUC robot in RoboGuide**  
   Since a virtual robot inside RoboGuide is not exposed in the same way as a physical controller, direct communication with external software is not straightforward. Ariadne uses **KAREL + Socket Messaging** to            establish bidirectional TCP communication between a virtual robot and Python running on the same PC.

2. **Natural-language motion control**  
   Once communication is established, external Python logic interprets user commands written in natural language, converts them into motion deltas, and sends them back to the robot. KAREL reconstructs the target            position, applies motion constraints, and the TP program executes motion in a continuous loop.

Ariadne is primarily a simulation and prototyping project, intended to explore how a virtual FANUC robot can be connected to modern external software and controlled in a more flexible and intuitive way than through standard robot-only programming.

## Inspiration for the Name

The name **Ariadne** was inspired by the mythological figure Ariadne, known for providing the thread that allowed Theseus to navigate the Labyrinth. In this project, that thread symbolizes the communication path connecting RoboGuide, KAREL, and Python. The name reflects the main technical challenge behind the project: finding a reliable route through a normally closed simulation environment and creating a working bridge between a virtual FANUC robot and external software. Ariadne therefore represents both guidance and connection — the link that makes natural-language robot control possible.

## Features

- **Robotics Layer**:
  - **TP Program**:
    - **ARIADNE_CORE**: Main teleoperation loop for continuous robot motion.
    - Calls KAREL communication programs in sequence.
    - Executes robot motion based on externally generated target positions.

  - **KAREL Programs**:
    - **ROBOT_TO_PY**: Sends the current robot pose from RoboGuide to Python.
    - **PY_TO_ROBOT**: Receives motion deltas from Python and generates the next target position.
    - Reconstructs the target position based on current pose + delta.
    - Applies workspace safety constraints before motion execution.
    - Preserves robot configuration data to keep position registers motion-valid.

- **Communication Layer**:
  - **Socket Messaging**:
    - Establishes bidirectional TCP communication between RoboGuide and Python.
    - Enables data exchange between a virtual FANUC robot and external software running on the same PC.
    - Supports both:
      - robot → Python current pose transfer
      - Python → robot motion delta transfer

- **External Control Layer**:
  - **Python Scripts**:
    - Handle communication with the virtual robot.
    - Receive current robot position data.
    - Convert user input into motion commands.
    - Send translation deltas back to the robot controller.

- **Natural Language Layer**:
  - **AI / Command Interpretation**:
    - Converts human-language commands into robot motion deltas.
    - Supports intuitive movement commands such as:
      - forward / backward
      - right / left
      - up / down
    - Uses current robot position as context for more natural command interpretation.

- **Safety Layer**:
  - **Motion Constraints**:
    - Z-axis motion limits
    - Cylindrical XY workspace limiter
    - Target reconstruction with configuration preservation
    - Demo-safe motion envelope for stable virtual testing

- **Simulation Layer**:
  - **RoboGuide Environment**:
    - Full project developed and tested in FANUC RoboGuide.
    - Designed to explore external robot control concepts entirely in simulation.
    - Provides a sandbox for prototyping advanced robotics workflows before real-world deployment.
   
## License

This project is available under an open-source license. Everyone is free to use, modify, and develop it further.
To run this project, RoboGuide is required. The project was written using RoboGuide ver. 9 rev. ZH.
Warning: Always test the project virtually before uploading it to a robot. Do not run it immediately in automatic mode on a real robot. It is recommended to use T1 or T2 mode first.
I am open to collaboration and any suggestions for further development
