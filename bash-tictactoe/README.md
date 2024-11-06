# Tic-Tac-Toe Game in Bash

## Description

Simple implementation of the classic Tic-Tac-Toe game written in Bash

## Features

- **Turn-Based Gameplay**: Players take turns to place their marks (X and O) on the board.
- **Save and Load Game**: Players can save the current game state to a file and load it later.
- **Play Against "AI"**: The game supports a mode where players can compete against a computer opponent, which chooses randomly available fields as his move
- **Colored interface**: Players markers are colored for better visibility

## How to Run

1. Clone or download the repository to your local machine.
2. Open a terminal and navigate to the directory containing the script.
3. Run:
   ```bash
   sh tictactoe.sh
   ```

## Gameplay Instructions

1. Upon starting the game, you will be prompted to select a game mode:
    1. Play against another player
    2. Play against the "AI"
    3. Load a previous game
2. Choose a mode by entering the corresponding number.
3. Players will take turns to choose a spot on the board by entering a number from $1$ to $9$, corresponding to the position on the grid.
4. If a player wants to save the current game state and exit, they can enter `S`.
5. The game will announce the winner or declare a draw when appropriate.

## Save example

_game_save.txt_
```
1                      <-- game mode
1                      <-- player turn
 , ,X, ,O,X, , ,       <-- board
```