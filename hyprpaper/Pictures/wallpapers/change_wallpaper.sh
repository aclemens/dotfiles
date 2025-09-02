#!/bin/bash

# Description:
# This script changes the wallpaper of hyprland.

CURRENT_WALLPAPER="$HOME/Pictures/wallpapers/current_wallpaper"
YAZI_SELECTION="$HOME/Pictures/wallpapers/selected"

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

function select_wallpaper() {
  yazi --chooser-file "$YAZI_SELECTION" || exit 1
  cat "$YAZI_SELECTION"
}

function cleanup_selection() {
  echo "Cleaning up selection file..."
  rm -f "$YAZI_SELECTION"
}

set -euo pipefail
trap cleanup_selection EXIT
source $HOME/.bash_functions

check_dependencies hyprctl hyprpaper yazi

wallpaper=$(select_wallpaper) || exit 1
set_wallpaper "$wallpaper"
restart_hyprpaper
