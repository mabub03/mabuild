#!/bin/bash

# Hardcode the paths or ensure they are passed via environment
# Since this is for a specific user on Silverblue:
MONITOR_DIR="/home/$(whoami)/Pictures"
DEST_DIR="/home/$(whoami)/Pictures/Screenshots/"

# Ensure the destination exists
mkdir -p "$DEST_DIR"

# --- Initial scan for existing files ---
# Using -not -path to avoid moving files already in the destination if it's a subfolder
find "$MONITOR_DIR" -maxdepth 1 -type f -name "Screenshot_*.png" -exec mv -t "$DEST_DIR" {} +

# Use inotifywait to monitor the directory
# Note: Using absolute path for inotifywait is safer in systemd
/usr/bin/inotifywait -m -e create -e moved_to --format "%f" "$MONITOR_DIR" | while read FILE
do
    if [[ "$FILE" == Screenshot_*.png ]]
    then
        mv "$MONITOR_DIR/$FILE" "$DEST_DIR"
    fi
done
