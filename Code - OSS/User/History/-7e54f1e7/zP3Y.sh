#!/bin/bash

# Variables
KEY="$1"
SINGLE_PRESS_ACTION="$2"
DOUBLE_PRESS_ACTION="$3"
DELAY=0.25  # Adjust this delay as needed

# Get the current time
CURRENT_TIME=$(date +%s%N)
LAST_TIME_FILE="/tmp/last_press_time_${KEY}"
LAST_TIME=$(cat "$LAST_TIME_FILE" 2>/dev/null || echo 0)

# Calculate the time difference
TIME_DIFF=$(echo "($CURRENT_TIME - $LAST_TIME) / 1000000000" | bc -l)

# Determine if it's a single or double press
if (( $(echo "$TIME_DIFF < $DELAY" | bc -l) )); then
    # Double press
    eval "$DOUBLE_PRESS_ACTION"
else
    # Single press
    eval "$SINGLE_PRESS_ACTION"
fi

# Update the last press time
echo $CURRENT_TIME > "$LAST_TIME_FILE"
