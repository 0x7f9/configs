#!/bin/bash

# start status bar
slstatus &

# start the audio services 
pulseaudio --start &

# set background images by cating a file to terminal
# eval `cat ~/.setbg` &

# set display for PC Machine
xrandr --output DP-0 --rotate right
xrandr --output DP-2 --mode 1920x1080 --rate 240 --primary --left-of DP-0

# auto HDMI display on laptops
# xrandr --output HDMI1 --auto

# restrict xhost to the local user only
xhost -
xhost +SI:localuser:space

# start dwm
exec dwm
