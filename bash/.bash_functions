#!/bin/bash

########################
# FUNCTION DEFINITIONS #
########################

function __check_dependencies() {
  local dependencies=("gum")
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
