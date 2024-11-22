#!/bin/bash

# Function to simulate decryption with a Pac-Man spinner
startDecryptingPacman() {
    local input="$1"
    local length=${#input}
    local hidden=$(printf '_%.0s' $(seq 1 $length))  # Start with underscores
    local pacman_frames=( "◐" "◓" "◑" "◒" )

    tput civis  # Hide the cursor
    local start_time=$(date +%s)

    # Determine random reveal direction: left-to-right, right-to-left, or random
    local mode=$(( RANDOM % 3 ))  # 0 = left-to-right, 1 = right-to-left, 2 = random

    while :; do
        # Get elapsed time
        local elapsed=$(( $(date +%s) - start_time ))

        # Reveal a character based on the chosen mode
        if [[ "$hidden" != "$input" ]]; then
            local pos
            if [[ $mode -eq 0 ]]; then
                # Left-to-right
                pos=$(echo "$hidden" | grep -o "_" | wc -l)
                pos=$(( length - pos ))
            elif [[ $mode -eq 1 ]]; then
                # Right-to-left
                pos=$(echo "$hidden" | grep -o "_" | wc -l)
                pos=$(( pos - 1 ))
            else
                # Random
                pos=$(( RANDOM % length ))
            fi

            if [[ "${hidden:$pos:1}" == "_" ]]; then
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
