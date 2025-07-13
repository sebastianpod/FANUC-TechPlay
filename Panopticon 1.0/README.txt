# Project Name: Panopticon 1.0

An experimental vision-guided robotics project for FANUC robots, created for fun and technological exploration.

## Table of Contents

- Description
- Inspiration for the Name
- Features
- License

## Description

Panopticon integrates FANUC robot 2D vision with external image processing. It lets a robot dynamically identify and trace up to 100 object vertices on a flat surface. Developed in FANUC RoboGuide.

This system operates without traditional iRVision teaching. All image processing and object detection happen in Python (with OpenCV), leveraging PC power for greater flexibility. It includes a calibration routine to map pixel coordinates to the robot's User Frame. For virtual testing, object Z-height is manually input, noting that real-world use would require 3D sensing.

Currently, the communication between the Python scripts and the robot controller involves manual transfer of image files and CSV data. This approach, though not fully automated, was chosen to simplify the project's scope for hobbyist development, allowing focus on the core vision and robot control logic.

This project is a robust foundation, primarily an initial step towards Panopticon 2.0. The next immediate goal is for the robot to hold the camera, actively exploring and interacting with its environment. It's a passion project, developed after hours, showcasing robotics and software synergy

## Inspiration for the Name

The name Panopticon is inspired by the architectural and philosophical concept of a circular prison, where a single observer can watch all inmates without them knowing they are being watched. In my project, the "Panopticon" camera acts as the central, all-seeing "eye" that continuously monitors the workspace, gathering information about the objects.

This name reflects the essence of a vision system that provides the robot with "omnipresent" awareness of its environment. It highlights its ability to see all objects within its field of view without needing to "teach" each individual item, unlike traditional iRVision setups. Just as the Panopticon ensures constant surveillance, our vision system grants the robot continuous insight into the positions and shapes of objects, enabling it to react dynamically and intelligently.

## Features

- **Robotics Layer**:
  - **TP Programs**:
    - **MAIN**: Main control program for robot operations, calling vision routine,KAREL program and trajectory execution.
    - **VISION_TOP_XY**: Genrated Fanuc Vision program to capture top-down images for X/Y coordinates. Since it's not taught, a system error will occur, requiring manual clearing on the Teach Pendant to proceed
    - **HOME_POSITION**: Ensures the robot returns to its home position.
    - **EXEC_CONTOUR_PATH**: Executes the robot's trajectory, tracing the detected object's contour and automatically returning to the start point to close the shape

- **Data Control Layer**:
  - **KAREL Programs**:
    - **READ_COORDS**: Reads pos data (XYZWPR) from coords.csv and loads it into Position Registers (PR). it also outputs the total number of detected vertices, ensuring the trajectory program uses only valid points and avoids issues with previously loaded, unused PRs
   
- **Image Processing Layer**:
  - **Python Libraries**:
    - **OpenCV (cv2)**: The core library used for all image loading, preprocessing (e.g., grayscale conversion), advanced contour detection, and precise vertex approximation.
    - **NumPy**: Essential for robust numerical operations, including efficient handling of image data arrays and coordinate transformations.
    - **JSON**: Utilized for saving and loading calibration parameters in a structured, easy-to-use format.

## License

This project is available under an open-source license. Everyone is free to use, modify, and develop it further.

To run this project, RoboGuide is required. The project was written using RoboGuide ver. 9 rev. ZH.

Warning: Always test the project virtually before uploading it to a robot. Do not run it immediately in automatic mode on a real robot. It is recommended to use T1 or T2 mode first.

I am open to collaboration and any suggestions for further development
