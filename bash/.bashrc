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

# alias definitions
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='la -l'
alias grep='grep --color=auto'
alias fvim='vim $(fzf --preview="bat --color=always {}")'
alias stow='stow -t $HOME'
alias cat='bat'

# set default editor to VIM
EDITOR=vim

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# setup zoxide
eval "$(zoxide init bash)"

PS1='[\u@\h \W]\$ '

fastfetch

