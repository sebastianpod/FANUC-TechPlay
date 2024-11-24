# Project Name: Telemachus

An experimental project involving FANUC robots, created for fun and technology exploration.

## Table of Contents

- Description
- Inspiration for the Name
- Features
- License

## Description

Telemachus uses machine learning to predict positional errors in FANUC robots. By analyzing data from FANUC’s system variables, it identifies patterns and anomalies that may indicate potential errors, ensuring greater precision in operations.

The project combines FANUC technology with Python, using libraries like Pandas for data manipulation and Scikit-learn for machine learning models (Random Forest, Linear Regression, Support Vector Regressor, K-Nearest Neighbors).

Data collection was done in a virtual RoboGuide environment, generating ideal data. This project is an exploratory attempt to understand the potential capabilities of FANUC robots and to seek synergy between robotics and modern data science technologies. It aims to spark curiosity and inspire future innovations.

## Inspiration for the Name

The name **Telemachus** was inspired by the mythological figure Telemachus, the son of Odysseus and Penelope. After the Trojan War, Telemachus embarked on a journey to find his missing father, guided by Mentor, who symbolized wisdom and guidance. In this project, Mentor represents the guidance and support the robot receives during its development. Just as Telemachus had Mentor to help him navigate challenges, the robot benefits from the synergy of combining various technical solutions, ensuring effective learning and growth.

The name "Telemachus" also has a sci-fi twist. The letter "T" at the beginning allows for a shorthand, similar to the Terminators from the famous film series, like the T-800. This robot, using machine learning, is in its early stages, so it can be called the T-100. Machine learning is a step towards AI, but don’t worry—this robot is here to help, not destroy!

## Features

- **Robotics Layer**:
  - **TP Programs**:
    - **MAIN**: Main control program for robot operations.
    - **CYCLE**: Manages the robot's operational cycles.
    - **HOMING**: Ensures the robot returns to its home position.
    - **TRAINING**: Collects data by moving the robot to predefined points.
    - **TRAJECTORY**: Controls the robot's movement along specified paths.
    - **TESTING**: Tests the robot's movements and collects data for analysis.

- **Data Control Layer**:
  - **KAREL Programs**:
    - **get_data**: Collects data from the robot's system variables.
    - **ModelToPos**: Converts model predictions to positional data.

- **ML Layer**:
  - **Python Libraries**:
    - **Pandas**: Used for data manipulation and analysis.
    - **Scikit-learn**: Implements machine learning models.
    - **StandardScaler**: Preprocesses data for machine learning.

## License

This project is available under an open-source license. Everyone is free to use, modify, and develop it further.

To run this project, RoboGuide is required. The project was written using RoboGuide ver. 9 rev. ZH.

Warning: Always test the project virtually before uploading it to a robot. Do not run it immediately in automatic mode on a real robot. It is recommended to use T1 or T2 mode first.

I am open to collaboration and any suggestions for further development
