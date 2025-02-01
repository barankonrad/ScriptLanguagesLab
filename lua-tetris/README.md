# Tetris in LÖVE (Lua)
A simple implementation of the classic **Tetris** game written in **Lua** using the LÖVE framework

## Features

- **Falling Blocks**: The classic Tetris mechanic of rotating and moving tetrominoes down the grid.
- **Multiple Tetromino Shapes**
- **Line Clearing with Animation**: Lines get cleared when fully filled, and blocks above fall down accordingly.
- **Save and Load**: The current game state (grid and falling block) can be saved to a file and loaded later.
- **Simple GUI Buttons**: Basic on-screen buttons for starting the game, saving, and loading.
- **Sound effect**: Action like rotation, placing block, clearing a row or losing does have a sound!

## How to run

1. Install [LÖVE](https://love2d.org/) on your system.
2. Clone or download this repository to your local machine.
3. Open a terminal and navigate to the directory containing the project.
4. Run:
   ```bash
   love .
   ```
This will launch the Tetris game in a new window.

## Gameplay Instructions

1. Once the game is loaded, press the **Start** (Play) button or hit the `Space` key (depending on the setup) to begin.
2. Use the **arrow keys**:
    - **Left/Right** to move the falling tetromino horizontally.
    - **Down** to speed up its fall.
    - **Space** to rotate it.
3. When a row is fully filled, it is cleared, and the rows above will fall down.
4. If you want to **save** the current game state, click the corresponding button. To **load** a saved game, click "Load" or use the button designed for that feature.
5. The game ends if a new block cannot be placed at the top of the grid.

## Save example

_game_save.txt_
```
5 2                <-- Tetromino.x, Tetromino.y
255 128 64         <-- Tetromino.color = {255, 128, 64}
2 3                <-- Shape height & width
1,1,1              <-- Shape rows
0,1,0
0 0 0 (255,0,0) 0  <-- Grid rows...
0 0 0 0 0  ...
```

This file describes:
1. The active tetromino’s position and color.
2. The shape’s matrix (how blocks are laid out).
3. The current state of the grid (which cells are empty `0` and which are colored `(r,g,b)`).

## Example
<div align="center">
   <img width="462" alt="Screenshot 2025-01-15 at 22 59 26" src="https://github.com/user-attachments/assets/df3a84c2-56c0-47bb-993d-387ec1c4ae1f" width="700" alt="Screenshot 1"/>
   <p><i>Screenshot 1: empty board</i></p>

  <img width="462" alt="Screenshot 2025-01-15 at 22 53 23" src="https://github.com/user-attachments/assets/f372b4a5-a733-4785-95b6-e30308995468" width="700" alt="Screenshot 2"/>
  <p><i>Screenshot 2: blocks on grid and active Tetromino</i></p>

https://github.com/user-attachments/assets/0d27b969-37b9-4d09-8130-240c23793647
  <p><i>Screenshot 3: lines being cleared</i></p>
</div>
