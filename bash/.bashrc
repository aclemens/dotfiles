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

#####################
# ALIAS DEFINITIONS #
#####################
# ls related aliases
alias ls='eza --group-directories-first --icons'
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -a'
alias tree='ls --tree'

# common app aliases
alias grep='grep --color=auto'
alias stow='stow -t $HOME'
alias cat='bat'
alias vim='nvim'
alias v='vim'
alias top='btop'
alias act='source .venv/bin/activate'
alias mvenv='python -m venv .venv'
alias yd='yt-dlp --embed-chapters -t mp4'

# backup aliases
alias tsc='sudo timeshift --snapshot-device /dev/sda3 --create'
alias tsl='sudo timeshift --snapshot-device /dev/sda3 --list'

# docker aliases
alias dirm='docker image ls --format "{{.Repository}}:{{.Tag}} {{.ID}}" | fzf --multi | awk "{print \$2}" | xargs -t -r docker image rm'
alias dcrm='docker container ls -a --format "{{.Names}} {{.ID}}" | fzf --multi | awk "{print \$2}" | xargs -t -r docker container rm'

# git related aliases
alias lg='lazygit'
alias gst='git status'

# yay related aliases
alias yayif='yay -Slq | sort -u | fzf --multi --preview "yay -Si {1}" | xargs -ro yay -Sy'
alias yayrf='yay -Qeq | sort -u | fzf --multi --preview "yay -Qi {1}" | xargs -ro yay -Rscn'
#####################

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
