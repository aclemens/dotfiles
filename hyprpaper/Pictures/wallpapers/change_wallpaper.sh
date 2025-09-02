#!/bin/bash

# Description:
# This script changes the wallpaper of the desktop environment.
# The wallpaper must be in the same directory as the script.
#
# Usage:
# ./change_wallpaper.sh <wallpaper>

CURRENT_WALLPAPER="$HOME/Pictures/wallpapers/current_wallpaper.jpg"
SELECTED="$HOME/Pictures/wallpapers/selected"

function check_and_convert_wallpaper() {
  local wallpaper="$1"
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
  local wallpaper="$1"
  echo "Setting wallpaper..."
  ln -fs "$wallpaper" "$CURRENT_WALLPAPER"
}

function restart_hyprpaper() {
  # Restart hyprpaper to apply the changes.
  echo "Restarting hyprpaper..."
  hyprctl -q hyprpaper unload "$CURRENT_WALLPAPER"
  hyprctl -q hyprpaper preload "$CURRENT_WALLPAPER"
  hyprctl -q hyprpaper wallpaper ",$CURRENT_WALLPAPER"
}

# --------------------------------------------------
# # MAIN SCRIPT
# --------------------------------------------------
set -euo pipefail

source $HOME/.bash_functions
check_dependencies magick hyprctl hyprpaper yazi

yazi --chooser-file "$SELECTED" || exit 1
wallpaper=$(<"$SELECTED")
rm -f selected

check_and_convert_wallpaper "$wallpaper"
set_wallpaper "$wallpaper"
restart_hyprpaper
