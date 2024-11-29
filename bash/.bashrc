#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='la -l'
alias grep='grep --color=auto'
alias fvim='vim $(fzf --preview="bat --color=always {}")'
alias stow='stow -t $HOME'

EDITOR=vim

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

PS1='[\u@\h \W]\$ '

fastfetch

