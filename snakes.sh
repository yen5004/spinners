#!/bin/bash

# Function to start the spinner
startSpinner() {
    spinner &
    SPINNER_PID=$!
    disown
}

# Spinner function
spinner() {
    local shs=( 100 800 1 8 10 20 80 40 8000 4000 400 200 100 900 801 9 18 30
        A0 C0 8040 C000 4400 600 300 900 901 809 19 38 B0 E0 80C0 C040 C400 4600
        700 B00 901 909 819 39 B8 F0 80E0 C0C0 C440 C600 4700 F00 B01 909 919
        839 B9 F8 80F0 C0E0 C4C0 C640 C700 4F00 F01 B09 919 939 8B9 F9 80F8
        C0F0 C4E0 C6C0 C740 CF00 4F01 F09 B19 939 9B9 8F9 80F9 C0F8 C4F0 C6E0
        C7C0 CF40 CF01 4F09 F19 B39 9B9 9F9 88F9 C0F9 C4F8 C6F0 C7E0 CFC0 CF41
        CF09 4F19 F39 BB9 9F9 89F9 C8F9 C4F9 C6F8 C7F0 CFE0 CFC1 CF49 CF19 4F39
        FB9 BF9 89F9 C9F9 CCF9 C6F9 C7F8 CFF0 CFE1 CFC9 CF59 CF39 4FB9 FF9 8BF9
        C9F9 CDF9 CEF9 C7F9 CFF8 CFF1 CFE9 CFD9 CF79 CFB9 4FF9 8FF9 C9F9 CCF9
        C6F9 C7F8 CFF0 CFE1 CFC9 CF59 CF39 4FB9 FF9 89F9 C8F9 C4F9 C6F8 C7F0
        CFE0 CFC1 CF49 CF19 4F39 FB9 9F9 88F9 C0F9 C4F8 C6F0 C7E0 CFC0 CF41
        CF09 4F19 F39 9B9 8F9 80F9 C0F8 C4F0 C6E0 C7C0 CF40 CF01 4F09 F19 939
        8B9 F9 80F8 C0F0 C4E0 C6C0 C740 CF00 4F01 F09 919 839 B9 F8 80F0 C0E0
        C4C0 C640 C700 4F00 F01 909 819 39 B8 F0 80E0 C0C0 C440 C600 4700 F00
        901 809 19 38 B0 E0 80C0 C040 C400 4600 700 900 801 9 18 30 A0 C0 8040
        C000 4400 600 )
    local chr pnt

    for pnt in "${!shs[@]}"; do
        chr="000${shs[pnt]}"
        printf -v shs[pnt] '%b' "\U28${chr: -4:2}\U28${chr: -2}"
    done


    while :; do
        for pnt in "${shs[@]}"; do
            printf '\e7%b\e8' "$pnt"
            sleep 0.02
        done
        if read -rsn1 -t 0.02; then
            break
        fi
    done
}
# Function to stop the spinner
stopSpinner() {
    kill "$SPINNER_PID" 2>/dev/null
}

# Example usage of the spinner
printf 'Snake two braille chars: '
startSpinner
sleep 12
stopSpinner
