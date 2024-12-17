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

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


#####################
# ALIAS DEFINITIONS #
#####################
# ls related aliases
alias ls='eza --header --git'
#alias ls='ls --color=auto'
alias la='ls -a'
alias ll='la -l'
alias tree='ls --tree'

# common app aliases
alias grep='grep --color=auto'
alias stow='stow -t $HOME'
alias cat='bat'
alias vim='nvim'
alias v='vim'
alias y='yazi'
alias top='btop'

#docker aliases
alias dirm='docker image ls --format "{{.Repository}}:{{.Tag}} {{.ID}}" | fzf --multi | awk "{print \$2}" | xargs -t -r docker image rm'
alias dcrm='docker container ls -a --format "{{.Names}} {{.ID}}" | fzf --multi | awk "{print \$2}" | xargs -t -r docker container rm'

# git related aliases
alias lg='lazygit'
alias gst='git status'
#####################


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

