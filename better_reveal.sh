#!/bin/bash

# Function to generate a random string of the same length as the input
generateRandomString() {
    local length=$1
    local chars='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()'
    local random=""
    for (( i = 0; i < length; i++ )); do
        random+="${chars:RANDOM % ${#chars}:1}"
    done
    echo "$random"
}

# Function to simulate decryption with a Pac-Man spinner
startDecryptingPacman() {
    local input="$1"
    local length=${#input}
    local hidden=$(generateRandomString "$length")  # Generate random string as initial hidden text
    local pacman_frames=( "◐" "◓" "◑" "◒" )

    tput civis  # Hide the cursor
    local start_time=$(date +%s)

    while :; do
        # Get elapsed time
        local elapsed=$(( $(date +%s) - start_time ))

        # Randomly decrypt a character every iteration
        if [[ "$hidden" != "$input" ]]; then
            local pos=$(( RANDOM % length ))  # Random position in the string
            if [[ "${hidden:$pos:1}" != "${input:$pos:1}" ]]; then
                hidden="${hidden:0:$pos}${input:$pos:1}${hidden:$(( pos + 1 ))}"
            fi
        fi

        # Print the decrypting animation
        for frame in "${pacman_frames[@]}"; do
            printf "\r%s %s" "$frame" "$hidden"
            sleep 0.2

            # Break after 10 seconds or when fully decrypted
            if (( elapsed >= 10 )) || [[ "$hidden" == "$input" ]]; then
                hidden="$input"
                break 2
            fi
        done
    done

    tput cnorm  # Restore the cursor
    echo  # Move to the next line
}

# Run the script with input
if [[ -z "$1" ]]; then
    echo "Usage: $0 <text to decrypt>"
    exit 1
fi

# Call the function with the provided input
startDecryptingPacman "$1"
