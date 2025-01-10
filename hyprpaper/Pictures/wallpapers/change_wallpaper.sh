#!/bin/bash

# Description:
# This script changes the wallpaper of the desktop environment.
# The wallpaper must be in the same directory as the script.
#
# Usage:
# ./change_wallpaper.sh <wallpaper>

set -e
set -u

# Read the wallpaper from the first argument.
# If there is not exactly 1 argument, print the usage and exit.
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <wallpaper>"
  exit 1
fi

wallpaper="$1"
wallpaper_link="current_wallpaper.jpg"

# Check if wallpaper exists, if not print an error message and exit.
if [[ ! -f "$wallpaper" ]]; then
  echo "Error: Wallpaper does not exist."
  exit 1
fi

# Check if the wallpaper is a jpg file, if not print an error message and exit.
if [[ $(file --mime-type -b "$wallpaper") != "image/jpeg" ]]; then
  echo "Error: Wallpaper must be a jpg file."
  exit 1
fi

# Set wallpaper as the current wallpaper.
echo "Setting $wallpaper_link -> $wallpaper"
ln -fs "$wallpaper" "$wallpaper_link"

# Restart hyprpaper to apply the changes. Move all output to /dev/null.
echo "Restarting hyprpaper..."
killall -q hyprpaper >/dev/null 2>&1 || true
hyprpaper >/dev/null 2>&1 &
