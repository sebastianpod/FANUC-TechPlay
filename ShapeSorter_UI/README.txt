
# Project Name: ShapeSorter_UI

An interactive Human-Robot Interface (HRI) prototype designed to demonstrate how operator panels can be created for process control. This project showcases a custom-built interface developed using Microsoft SharePoint Designer 2007 and HTML, focusing on simplicity and adaptability for industrial applications.

The primary goal of this project is to show that, for simple applications where operator interaction requirements are minimal, the FANUC teach pendant and its built-in capabilities can be used to create a custom operator HMI panel without external devices. 
While this approach is limited and not suitable for most complex industrial scenarios, it serves as an educational example of what is possible with existing resources.

## Table of Contents

- Description
- Features
- Instalation
- License

## Description

ShapeSorter_UI is an educational prototype that demonstrates how a custom Human-Robot Interface (HRI) can be implemented directly on a FANUC teach pendant for simple applications. The goal is to show that, when operator interaction requirements are minimal, the teach pendant can serve as a basic HMI without external hardware.

The project simulates a shape-sorting task where the robot arranges elements on a 4x4 chessboard according to a user-defined pattern. Available elements include:
  - **Box**: a green cube
  - **Hex**: a hexagonal prism
  - **Empty**: a blank cell

The interface workflow:
  - **Element Selection**: The user selects the active element type (Box, Hex, or Empty) using dedicated ActiveX `ToggleButton` controls on the left panel.
  - **Grid Editing**: The center of the screen displays a dynamic 4x4 grid representing the chessboard. Each cell contains:
    - **MultiControl ActiveX**: Displays the corresponding image (Box, Hex, or Empty) and updates dynamically based on the value of its associated numeric register (R[1] to R[16]).
    - **ToggleButton Control**: Allows the user to apply the selected element to the chosen cell.
  - **Execution**: After defining the pattern, the program is started in FANUC RoboGuide simulation. The robot then arranges the virtual elements according to the configured layout.

This project focuses on layout design, visualization, and basic interaction rather than advanced automation or real-time communication. It serves as a practical example for training, experimentation, and proof-of-concept scenarios, showcasing how legacy tools like Microsoft SharePoint Designer 2007 and ActiveX components can be creatively applied in robotics environments.

## Features

- **Interface Features**
	- **Element Selection Panel (Left Side)**  
 		 - Three dedicated ActiveX `ToggleButton` controls allow the user to select the active element type:
    			- **Box** (green cube)
    			- **Hex** (hexagonal prism)
    			- **Empty** (blank cell)
  		- Each button updates **Register R[19] (ELEMENT_ID)** as follows:
    			- **Box** → `1` when TRUE, `0` when FALSE
    			- **Hex** → `2` when TRUE, `0` when FALSE
    			- **Empty** → `3` when TRUE, `0` when FALSE
  		- The register always stores the latest selected element type.
  		- These buttons are FANUC-compatible and implemented using legacy ActiveX components provided for teach pendant customization.

- **Dynamic 4x4 Grid (Center)**  
  - Represents the chessboard layout where the pattern is defined.
  - Each cell contains two ActiveX components:
    - **MultiControl**: Displays the corresponding image (Box, Hex, or Empty) and updates dynamically based on the value of its associated register (`R[1]` to `R[16]`).
    - **ToggleButton Control**: Allows the user to apply the selected element to the chosen cell.
  - Provides visual feedback of the pattern being created.


**Note:** Detailed information about all FANUC ActiveX components and their properties can be found in the official manual:  
**iPendant Customization Operator Manual [B-83594EN_01]**

### **Controller (Background) Logic**


Two background programs run continuously on the FANUC controller to manage user input and maintain data integrity:

### 1) `HRI_mapping` — Mapping User Selection to the Grid
This program updates the selected cell with the currently chosen element type.

- **Registers used:**
  - `R[18]` → **CELL_NUM** (1–16): The cell being edited.
  - `R[19]` → **ELEMENT_ID**: The active element type (1 = BOX, 2 = HEX, 3 = EMPTY).
    - This register is controlled by the Element Selection Panel (ActiveX ToggleButtons).
    - When no button is active, `R[19]` is set to `0`.

- **Logic:**
  - If both `R[18]` and `R[19]` are non-zero, the program writes the selected element to the corresponding cell register:
    ```
    R[R[18]] = R[19]
    ```
  - This ensures that the grid state (R[1]…R[16]) reflects the user’s latest selection.

---

### 2) `grid_sanitizer` — Validating Cell Values
This program continuously checks all 16 cell registers to ensure they contain only valid values:
- `1` = BOX
- `2` = HEX
- `3` = EMPTY

If any register is set to a value outside this range (for example, by manual input on the teach pendant), it is automatically corrected to `3` (EMPTY).

> **Technical note:** FANUC Background Logic does not support loops or iterative commands.  
> Each register must be validated individually using `IF` statements.

---

These two programs guarantee that user interactions on the HRI panel are correctly mapped to the robot’s internal logic and that the grid remains consistent at all time

## License

This project is available under an open-source license. Everyone is free to use, modify, and develop it further.

To run this project, RoboGuide is required. The project was written using RoboGuide ver. 9 rev. ZH.

Warning: Always test the project virtually before uploading it to a robot. Do not run it immediately in automatic mode on a real robot. It is recommended to use T1 or T2 mode first.

I am open to collaboration and any suggestions for further development




