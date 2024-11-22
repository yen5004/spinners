!/bin/bash

# Function to start the Pac-Man spinner
startPacmanSpinner() {
    tput civis  # Hide the cursor
    pacmanSpinner &
    SPINNER_PID=$!
    disown
}

# Pac-Man spinner function
pacmanSpinner() {
    local pacman_frames=( "◐" "◓" "◑" "◒" )
    local dots=""

    while :; do
        for frame in "${pacman_frames[@]}"; do
            printf "\r%s %s" "$frame" "$dots"
            dots+="."
            sleep 0.2
        done

        if read -rsn1 -t 0.1; then
            break
        fi
    done
}

# Function to stop the spinner
stopPacmanSpinner() {
    kill "$SPINNER_PID" 2>/dev/null
    tput cnorm  # Show the cursor again
    echo  # Move to the next line
}

# Example usage of the Pac-Man spinner
printf 'Pac-Man spinner: '
startPacmanSpinner
sleep 10
stopPacmanSpinner

