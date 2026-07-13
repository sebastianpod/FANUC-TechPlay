
# Project Name: FANUC_XO_Battle

FANUC_XO_Battle is a hobby robotics project created in FANUC ROBOGUIDE as a playful way to explore multi-robot simulation, custom teach pendant interfaces, KAREL programming, and motion coordination using two FANUC robots on a single controller. The project turns a simple Tic-Tac-Toe game into an interactive robot demonstration, where Robot 1 plays as O, Robot 2 plays as X, and the user controls the game from a custom browser-based interface on the FANUC iPendant.

## Table of Contents

- Description
- Features
- Instalation
- License


## Description

FANUC_XO_Battle simulates a fully playable Tic-Tac-Toe game in FANUC ROBOGUIDE. The game runs on one controller with two motion groups: Robot 1 places O symbols and Robot 2 places X symbols. The player selects the target cell from a custom HMI displayed in the FANUC teach pendant browser, while the simulation program handles move validation, robot motion, pick/drop animation, board updates, turn switching, win detection, and draw detection.

A key part of the project is the custom user interface. The game starts with a retro arcade-style intro created in KAREL, including animated text banners such as **FANUC XO BATTLE** and **FIGHT!**. After the intro sequence, the KAREL program automatically opens the FANUC browser page, bringing the operator directly to the playable Tic-Tac-Toe HMI on the teach pendant.

The browser-based interface is built as a custom iPendant HMI using FANUC-compatible ActiveX controls. The user selects a board cell from a 3x3 interface, and the HMI writes the selected cell number into a controller register. The HMI also visualizes the current board state by reading the cell registers and displaying the corresponding empty, O, or X graphics. This keeps the interface simple: the HMI only handles user input and visualization, while the controller programs handle the actual game logic.

The robot sequence is organized around a shared game state stored in numeric registers. Registers `R[1]` to `R[9]` represent the board cells, `R[10]` stores the current turn, `R[11]` stores the game status, `R[12]` stores the winner symbol, and `R[13]` stores the selected cell from the HMI. This structure allowed the game logic to remain independent from the individual robot motion programs, making the project easier to debug and extend.

## Features

- **Two robots on a single FANUC controller**  
    The project uses two robot motion groups on one controller This allowed the game to use one shared set of registers, one shared board state, and one common game logic structure 

- **Custom retro arcade-style intro**  
   A KAREL-based start sequence displays an arcade-inspired introduction before the game begins. The intro shows animated text banners, then automatically opens the playable browser HMI


- **Browser-based iPendant HMI**  
  The game is controlled from a custom FANUC browser interface displayed directly on the teach pendant. The operator selects a cell on a 3x3 board, while the interface dynamically displays the current board state

- **ROBOGUIDE pick and drop animation**  
  The main simulation program uses ROBOGUIDE-specific pick and drop instructions to visualize the full gameplay process. 


