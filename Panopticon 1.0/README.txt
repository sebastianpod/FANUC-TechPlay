# Project Name: Panopticon 1.0

An experimental vision-guided robotics project for FANUC robots, created for fun and technological exploration.

## Table of Contents

- Description
- Inspiration for the Name
- Features
- Setup and Usage
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
    - **READ_COORDS**: Reads pos data (XYZWPR) from coords.csv and loads it into PR[n]. It outputs the total number of detected vertices, ensuring the program uses only valid PR 

- **Image Processing Layer**:
  - **Python Libraries**:
    - **OpenCV (cv2)**: The core library used for all image loading, preprocessing (e.g., grayscale conversion), advanced contour detection, and precise vertex approximation.
    - **NumPy**: Essential for robust numerical operations, including efficient handling of image data arrays and coordinate transformations.
    - **JSON**: Utilized for saving and loading calibration parameters in a structured, easy-to-use format.

## Setup and Usage

- **FANUC RoboGuide Setup**:
  - Ensure you have RoboGuide ver. 9 rev. ZH (or a compatible version) installed
  - You can either load the provided .rgx cell file directly or configure your aplication manually using the TP and KAREL programs available in the repository
  - If configuring manually, your User Frame must be built using the FANUC calibration grid (available in RoboGuide) with the 4-point method according to best practices for creating UF with the 4-point method

- **Verify Paths**:
  - Crucially, check and adjust all file paths:
    - In the KAREL program, verify the path for reading the coords.csv file.
    - In your FANUC Vision System settings, confirm the path where captured images are saved.
    - In Python scripts (calibration.py, readout.py), ensure the image file paths and coords.csv output path are correct.

- **Calibration Phase**:Access the robot's web browser interface
  - Place a black rectangle of known dimensions (the entire Panopticon application operates in black and white only) in the camera's field of view within RoboGuide.
  - On the FANUC Teach Pendant, run the MAIN program. The un-taught vision program will capture and save an image, but it will halt due to non-detection.
  - Manually clear the error on the Teach Pendant and select ABORT ALL to reset the robot program.
  - Transfer the captured calibration image to your Python project directory.
  - Run calibration.py. Provide the path to the calibration image and its real-world dimensions when prompted. You will be also asked for the pixel X and Y coordinates for System Origin (0,0):
    - Access the robot's web browser interface.
    - Go to iRVision setup.
    - Select your specific camera (auto-generated data).
    - On the Calibration points page, find the Hz (Horizontal) and Vt (Vertical) values for the System Origin point (0,0). These are your required pixel coordinates.

- **Operation Phase**:
  - In RoboGuide, place the object you wish to recognize in the camera's field of view.
  - On the FANUC Teach Pendant, run the MAIN program. Again, the vision program will capture an image and halt with an error (due to non-detection).
  - Reset this error on the Teach Pendant. Then, resume the MAIN program from the line immediately following the CALL VISION_TOP_XY instruction.
  - The robot will proceed to execute the trajectory around the recognized shape.

## License

This project is available under an open-source license. Everyone is free to use, modify, and develop it further.

To run this project, RoboGuide is required. The project was written using RoboGuide ver. 9 rev. ZH.

Warning: Always test the project virtually before uploading it to a robot. Do not run it immediately in automatic mode on a real robot. It is recommended to use T1 or T2 mode first.

I am open to collaboration and any suggestions for further development
