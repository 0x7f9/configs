# .bash_profile

# get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

# prevent startx from running in tmux or outside of tty1
if [[ -z "$TMUX" && -z "$DISPLAY" && $(tty) = /dev/tty1 ]]; then
    startx -- -nolisten tcp
fi

# startx -- -nolisten tcp
