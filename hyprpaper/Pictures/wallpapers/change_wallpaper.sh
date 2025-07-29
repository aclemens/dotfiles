#!/bin/bash

# Description:
# This script changes the wallpaper of the desktop environment.
# The wallpaper must be in the same directory as the script.
#
# Usage:
# ./change_wallpaper.sh <wallpaper>

function check_dependencies() {
  # Check if required commands are available
  local cmds="$@"
  for cmd in $cmds; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "Error: $cmd is not installed. Please install it to use this script."
      exit 1
    fi
  done
}

function check_and_convert_wallpaper() {
  # if the wallpaper is not a jpeg but an image file, convert it to jpeg.
  if [[ ! -f "$wallpaper" ]]; then
    echo "Error: File '$wallpaper' does not exist."
    exit 1
  fi
  if [[ $(file --mime-type -b "$wallpaper") != "image/jpeg" ]]; then
    # ask the user if they want to convert the wallpaper to jpeg.
    read -p "The wallpaper is not in JPEG format. Do you want to convert it to JPEG? (y/n): " choice
    if [[ "$choice" != "y" && "$choice" != "Y" ]]; then
      echo "Exiting without changing the wallpaper."
      exit 0
    fi
    echo "Converting to JPEG format..."
    new_wallpaper="${wallpaper%.*}.jpg"
    magick "$wallpaper" "$new_wallpaper"
    wallpaper="$new_wallpaper"
  fi
}

function set_wallpaper() {
  # Set wallpaper as the current wallpaper.
  local wallpaper_link="current_wallpaper.jpg"
  echo "Setting $wallpaper_link -> $wallpaper"
  ln -fs "$wallpaper" "$wallpaper_link"
}

function restart_hyprpaper() {
  # Restart hyprpaper to apply the changes.
  echo "Restarting hyprpaper..."
  killall -q hyprpaper >/dev/null 2>&1 || true
  hyprpaper >/dev/null 2>&1 &
}

# --------------------------------------------------
# # MAIN SCRIPT
# --------------------------------------------------
set -e
set -u

# Check if the correct number of parameters is passed
if [[ "$#" -ne 1 ]]; then
  echo "Usage: $0 <wallpaper>"
  exit 1
fi

wallpaper="$1"

check_dependencies magick hyprpaper
check_and_convert_wallpaper
set_wallpaper
restart_hyprpaper
