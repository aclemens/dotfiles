#!/bin/bash

########################
# FUNCTION DEFINITIONS #
########################

# Checks for presence of commands (provided as a list of arguments).
# Returns 0 if all present, 1 if missing.
# If missing, prompts to install via pacman if available.
check_dependencies() {
  local dependencies=("$@")
  local missing=()
  local cmd

  # check if gum is installed
  if ! command -v gum >/dev/null 2>&1; then
    echo "gum is required for this script to run. Please install gum and retry."
    return 1
  fi

  # if no dependencies provided, return
  if [ -z "$dependencies" ]; then
    return 0
  fi

  for cmd in "${dependencies[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      missing+=("$cmd")
    fi
  done

  if [ ${#missing[@]} -eq 0 ]; then
    return 0
  fi

  echo "The following dependencies are missing: ${missing[*]}"

  if gum confirm "Attempt to install missing dependencies now?"; then
    # detect pacman
    if command -v pacman >/dev/null 2>&1; then
      log "Attempting to install missing packages with pacman..."
      sudo pacman -S --needed --noconfirm "${missing[@]}" || err "pacman failed to install packages. Please install them manually."
    else
      echo "No supported package manager detected. Install: ${missing[*]}" && return 1
    fi
  fi
  echo "Install the missing dependencies and retry." && return 1
}

man() {
  /usr/bin/man "$@" | bat -l man -p
}
