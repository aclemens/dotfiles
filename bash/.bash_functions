#!/bin/bash

########################
# FUNCTION DEFINITIONS #
########################

# logging helpers
log() { printf '%s\n' "$*"; }
err() { printf 'error: %s\n' "$*" >&2; }

# __check_dependencies [pkg...]
# Checks for presence of commands (defaults: gum gallery-dl yazi uv).
# Returns 0 if all present, 1 if missing.
# If missing, prompts to install via pacman if available.
function __check_dependencies() {
  local dependencies=("gum" "gallery-dl" "yazi" "uv" "fzf")
  local missing=()
  local cmd

  for cmd in "${dependencies[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      missing+=("$cmd")
    fi
  done

  if [ ${#missing[@]} -eq 0 ]; then
    return 0
  fi

  err "The following dependencies are missing: ${missing[*]}"

  if gum confirm "Attempt to install missing dependencies now?"; then
    # detect pacman
    if command -v pacman >/dev/null 2>&1; then
      log "Attempting to install missing packages with pacman..."
      if sudo pacman -S --needed --noconfirm "${missing[@]}"; then
        return 0
      else
        err "pacman failed to install packages. Please install them manually."
        return 1
      fi
    else
      err "No supported package manager detected. Install: ${missing[*]}"
      return 1
    fi
  fi

  err "Install the missing dependencies and retry."
  return 1
}

# chdir <dir>
# Safely change directory; returns non-zero on failure. Does NOT exit the shell.
function chdir() {
  local TARGET_DIR="$1"
  if [ -z "${TARGET_DIR:-}" ]; then
    err "usage: chdir <dir>"
    return 2
  fi

  if [ ! -d "$TARGET_DIR" ]; then
    err "Directory $TARGET_DIR does not exist."
    return 1
  fi

  if ! cd -- "$TARGET_DIR"; then
    err "Failed to change directory to $TARGET_DIR"
    return 1
  fi

  return 0
}

# pdownload
# Downloads gallery items listed in gallery-downloads.txt into /mnt/data,
# runs uv tasks to collect newest images, and optionally opens them in yazi.
function pdownload() {
  __check_dependencies || return 1

  local DATA_DIR="/mnt/data"
  local NEWEST_IMAGES_DIR="$DATA_DIR/gallery-dl/newest_images"
  local PREV_PWD
  PREV_PWD="$(pwd)"
  # ensure we always return to previous directory
  cleanup_pdownload() { cd -- "$PREV_PWD" >/dev/null 2>&1 || true; }
  trap cleanup_pdownload RETURN

  if ! chdir "$DATA_DIR"; then
    err "Data directory $DATA_DIR unavailable"
    return 1
  fi

  gallery-dl -i gallery-downloads.txt

  if ! chdir "$NEWEST_IMAGES_DIR"; then
    err "Newest images directory $NEWEST_IMAGES_DIR not available"
    return 1
  fi

  uv run newest_images clean || err "uv clean failed"
  uv run newest_images find .. || err "uv find failed"

  if gum confirm "Do you want to open yazi for viewing images now?"; then
    yazi "$NEWEST_IMAGES_DIR/images"
  fi
}
