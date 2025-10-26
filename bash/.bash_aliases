#!/bin/bash

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
alias ts="sudo timeshift"
alias tsc='ts --create'
alias tsl='ts --list'
alias tsr='ts --restore'
alias tsd='ts --delete'

# docker aliases
alias dirm='docker image ls --format "{{.Repository}}:{{.Tag}} {{.ID}}" | fzf --multi | awk "{print \$2}" | xargs -t -r docker image rm'
alias dcrm='docker container ls -a --format "{{.Names}} {{.ID}}" | fzf --multi | awk "{print \$2}" | xargs -t -r docker container rm'

# git related aliases
alias lg='lazygit'
alias gst='git status'

# yay related aliases
alias yayif='yay -Slq | sort -u | fzf --multi --preview "yay -Si {1}" | xargs -ro yay -Sy'
alias yayrf='yay -Qeq | sort -u | fzf --multi --preview "yay -Qi {1}" | xargs -ro yay -Rscn'
alias yayd='yay -Syuw'
alias yayc='yay -Qdtq | xargs -ro yay -Rscn'
#####################
