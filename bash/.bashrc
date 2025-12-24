#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# Set the maximum number of commands to remember in the history
HISTSIZE=100000

# Set the maximum number of lines contained in the history file
HISTFILESIZE=200000

export UV_CACHE_DIR=/mnt/data/.cache/uv

# set default editor to VIM
VISUAL=nvim
EDITOR=nvim

PS1='[\u@\h \W]\$ '

# set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# set up starship integration
eval "$(starship init bash)"

# set up zoxide
eval "$(zoxide init --cmd cd bash)"

# shell wrapper for yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

. "$HOME/.local/bin/env"

# source alias and function definitions
. "$HOME/.bash_aliases"
. "$HOME/.bash_functions"
. "/home/andi/.bash_batify"


# Load Angular CLI autocompletion.
source <(ng completion script)
export PATH="/home/andi/.local/bin:/usr/local/bin:/usr/bin:/home/andi/.dotnet/tools"
. "$HOME/.config/godotenv/env" # Added by GodotEnv

