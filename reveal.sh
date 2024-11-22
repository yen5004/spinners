#!/bin/bash

# Function to start the Pac-Man spinner with reveal effect
startPacmanReveal() {
    local input="$1"
    local revealed=""  # Holds the revealed part of the input
    local hidden="${input//?/#}"  # Replace each character with '#'
    local length=${#input}
    local pacman_frames=( "◐" "◓" "◑" "◒" )

    tput civis  # Hide the cursor
    local start_time=$(date +%s)

    while :; do
        # Get elapsed time
        local elapsed=$(( $(date +%s) - start_time ))

        # Reveal one character every second
        if (( elapsed < length )); then
            revealed="${input:0:elapsed}"
            hidden="${hidden:1}"
        else
            revealed="$input"
            hidden=""
        fi

        # Print the reveal and Pac-Man animation
        for frame in "${pacman_frames[@]}"; do
            printf "\r%s %s%s" "$frame" "$revealed" "$hidden"
            sleep 0.2

            # Break out after 10 seconds
            if (( elapsed >= 10 )); then
                break 2
            fi
        done
    done

    tput cnorm  # Restore the cursor
    echo  # Move to the next line
}

# Run the script with input
if [[ -z "$1" ]]; then
    echo "Usage: $0 <text to reveal>"
    exit 1
fi

# Call the function with the provided input
startPacmanReveal "$1"
