#!/bin/bash

# Description:
# This script changes the wallpaper of the desktop environment.
# The wallpaper must be in the same directory as the script.
#
# Usage:
# ./change_wallpaper.sh <wallpaper>

set -e
set -u

wallpaper_link="current_wallpaper.png"

# Read the wallpaper from the first argument.
# If there is not exactly 1 argument, print the usage and exit.
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <wallpaper>"
  exit 1
fi

wallpaper="$1"

# Check if wallpaper exists, if not print an error message and exit.
if [ ! -f "$wallpaper" ]; then
  echo "Error: Wallpaper does not exist."
  exit 1
fi

# Check if the wallpaper is a png file, if not print an error message and exit.
if [[ $(file --mime-type -b "$wallpaper") != "image/png" ]]; then
  echo "Error: Wallpaper must be a png file."
  exit 1
fi

# Set the current wallpaper to the given wallpaper.
echo "Setting $wallpaper_link -> $wallpaper"
ln -fs "$wallpaper" "$wallpaper_link"

# Restart hyprpaper to apply the changes. Move all output to /dev/null.
echo "Restarting hyprpaper..."
killall -q hyprpaper >/dev/null 2>&1 || true
hyprpaper >/dev/null 2>&1 &
