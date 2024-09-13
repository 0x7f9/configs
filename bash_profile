# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# Add this condition to prevent startx from running in tmux or non-interactive shells
if [[ -z "$TMUX" && -z "$DISPLAY" && $(tty) = /dev/tty1 ]]; then
    startx -- -nolisten tcp
fi

# startx -- -nolisten tcp
