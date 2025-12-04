# Project name: SCARA Unloading 

A project demonstrating the integration of FANUC SCARA robots with vision systems for automated part handling

## Table of Contents

- Description
- Features
- License

## Description

This project showcases the use of FANUC SCARA robots equipped with vision systems to automate the process of picking randomly falling parts from a grinder onto a rotating table. The robot utilizes a vision system to identify and pick parts from the rotating table and place them onto one of two stationary tables, each containing four trays. If all trays on one table are filled, the robot switches to filling the trays on the other table.

## Features

- Main Job Program: Automatically generated from the simulation in the RoboGuide environment.
- Offset Programs: Includes an offset program to control the placement of parts on trays and an offset reverse program to manage the table on the other side.
- Vision System Integration: Utilizes sophisticated vision systems for accurate part detection and handling.
- Simulation Available: The vision program is not included in the repository but is available in the packaged simulation accessible in this repository.
- Tray Activation Requirement: Before starting the program, declare which trays are active for unloading. There are two tables (Left and Right), each with four trays. Presence sensors are simulated using DO[1]–DO[8].

## License

This project is available under an open-source license. Everyone is free to use, modify, and develop it further.

To run this project, RoboGuide is required. The project was written using RoboGuide ver. 9 rev. ZH.

Warning: Always test the project virtually before uploading it to a robot. Do not run it immediately in automatic mode on a real robot. It is recommended to use T1 or T2 mode first.

I am open to collaboration and any suggestions for further development
