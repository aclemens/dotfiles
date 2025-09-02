#!/bin/bash

########################
# FUNCTION DEFINITIONS #
########################

function __check_dependencies() {
  local dependencies=("gum" "gallery-dl" "yazi")
  local missing=()

  for cmd in "${dependencies[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
      missing+=("$cmd")
    fi
  done

  if [ ${#missing[@]} -ne 0 ]; then
    echo "The following dependencies are missing:"
    for dep in "${missing[@]}"; do
      echo " - $dep"
    done

    # if gum is installed, ask the user to install dependencies automatically
    if command -v gum &>/dev/null; then
      if gum confirm "Do you want me to try to install them for you?"; then
        sudo pacman -S --needed --noconfirm "${missing[@]}"
        # if pacman fails, stop the script
        if [ $? -ne 0 ]; then
          echo "Failed to install dependencies. Please install them manually."
          return 1
        fi
      else
        echo "Please install them and try again."
        return 1
      fi
    fi
  fi
}

function chdir() {
  local TARGET_DIR="$1"
  local CURRENT_DIR="$(pwd)"
  if [ -d "$TARGET_DIR" ]; then
    cd "$TARGET_DIR"
  else
    echo "Directory $TARGET_DIR does not exist."
    exit 1
  fi
}

function pdownload() {
  __check_dependencies || return 1

  local DATA_DIR="/mnt/data"
  local NEWEST_IMAGES_DIR="$DATA_DIR/gallery-dl/newest_images"

  # remember current directory
  local CURRENT_DIR="$(pwd)"

  chdir "$DATA_DIR"

  gallery-dl -i gallery-downloads.txt

  chdir "$NEWEST_IMAGES_DIR"

  uv run newest_images clean
  uv run newest_images find ..
  gum confirm "Do you want to open yazi for viewing images now?" && yazi "$NEWEST_IMAGES_DIR/images"
  cd "$CURRENT_DIR" || return 1
}
