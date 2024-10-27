# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# PS1='[\u@\h \W]\$ '
PS1="\[$(tput bold)\]\[$(tput setaf 15)\][\[$(tput setaf 69)\]\u\[$(tput setaf 178)\]@\h \[$(tput setaf 140)\]\W\[$(tput setaf 15)\]]\[$(tput sgr0)\]\$ "

. "$HOME/.cargo/env"
