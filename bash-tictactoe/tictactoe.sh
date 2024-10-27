#!/bin/bash

RED='\033[0;31m'
BLUE='\033[0;34m'
COLOR_RESET='\033[0m'
X_CHAR="X"
O_CHAR="O"
board=(" " " " " " " " " " " " " " " " " ")
move=0
turn=0
mode=0

color_symbol() {
  local symbol=$1
  if [[ $symbol == "X" ]]; then
    echo -e "${RED}X${COLOR_RESET}"
  elif [[ $symbol == "O" ]]; then
    echo -e "${BLUE}O${COLOR_RESET}"
  else
    echo "$symbol"
  fi
}

display_board() {
  echo " $(color_symbol "${board[0]}") | $(color_symbol "${board[1]}") | $(color_symbol "${board[2]}") "
  echo "---+---+---"
  echo " $(color_symbol "${board[3]}") | $(color_symbol "${board[4]}") | $(color_symbol "${board[5]}") "
  echo "---+---+---"
  echo " $(color_symbol "${board[6]}") | $(color_symbol "${board[7]}") | $(color_symbol "${board[8]}") "
}

update_board() { # $1 - player char # $2 - position
    board[$2 - 1]=$1
}

is_board_full() {
    for i in {0..8}; do
        if [[ ${board[i]} == " " ]]; then
            return 1
        fi
    done
    return 0
}

computer_move() {
    local available_moves=()
    for i in {0..8}; do
        if [[ ${board[i]} == " " ]]; then
            available_moves+=($i)
        fi
    done
    move=$((available_moves[RANDOM % ${#available_moves[@]}] + 1))
}

check_rows() { # $1 - player char
    for i in 0 3 6; do
        if [[ ${board[i]} == "$1" && ${board[i+1]} == "$1" && ${board[i+2]} == "$1" ]]; then
            return 0
        fi
    done
    return 1
}

check_columns() { # $1 - player char
    for i in 0 1 2; do
        if [[ ${board[i]} == "$1" && ${board[i+3]} == "$1" && ${board[i+6]} == "$1" ]]; then
            return 0
        fi
    done
    return 1
}

check_diagonals() { # $1 - player char
    if [[ ${board[0]} == "$1" && ${board[4]} == "$1" && ${board[8]} == "$1" ]]; then
        return 0
    fi
    if [[ ${board[2]} == "$1" && ${board[4]} == "$1" && ${board[6]} == "$1" ]]; then
        return 0
    fi
    return 1
}

check_winner() { # $1 - player char
    if check_rows "$1" || check_columns "$1" || check_diagonals "$1"; then
        return 0
    fi
    return 1
}

load_game() {
    if [[ ! -f game_save.txt ]]; then
        echo "There's no any save!"
        exit 1
    fi

    local line_count=0
    while IFS= read -r line; do
        if [[ $line_count -eq 0 ]]; then
            mode=$line
        elif [[ $line_count -eq 1 ]]; then
            turn=$line
        elif [[ $line_count -eq 2 ]]; then
            IFS=',' read -r -a board <<< "$line"
        fi
        ((line_count++))
    done < game_save.txt
    echo "Successfully loaded game!"
}

save_game() {
    echo "Saving game status to: game_save.txt..."
    {
        echo "$mode"
        echo "$turn"
        echo "$(IFS=','; echo "${board[*]}")"
    } > game_save.txt
    exit 0
}

read_input() {
    local input
    while true; do
        echo "Select digit [0-9] to choose a spot"
        echo "Select \`S\` to save current game and quit"
        read -p "Your input: " input
        if [[ "$input" =~ ^[1-9]$ ]]; then
            if [ "${board["$input" - 1]}" == " " ]; then
                move="$input"
                return
            else
                echo "That spot is already taken!"
            fi
        elif [[ "$input" == "S" ]]; then
            save_game
        else
            echo "Invalid options, please try again"
        fi
    done
}

handle_game() {
    while true; do
        display_board
        if [[ $turn == 0 ]]; then
            read_input
            update_board "$X_CHAR" "$move"
            if check_winner "$X_CHAR"; then
                clear
                echo "$X_CHAR wins!"
                display_board
                break
            fi
            turn=1
        else
            if [[ $mode == 2 ]]; then
                computer_move
                echo "AI chooses: $move"
            else
                read_input
            fi
            update_board "$O_CHAR" "$move"
            if check_winner "$O_CHAR"; then
                clear
                echo "$O_CHAR wins!"
                display_board
                break
            fi
            turn=0
        fi
        if is_board_full; then
              clear
              echo "Draw! The board is full"
              display_board
              break
        fi
        clear
    done
}

select_mode() {
    echo "Choose game mode:"
    echo "1 - Against another player"
    echo "2 - Against AI"
    echo "3 - Load previous game"
    while true; do
        read -p "Your choice: " mode
        if [[ "$mode" == "1" || "$mode" == "2" ]]; then
            return
        elif [[ "$mode" == "3" ]]; then
            load_game
            return
        else
            echo "Invalid option, please try again"
        fi
    done
}

select_mode
handle_game