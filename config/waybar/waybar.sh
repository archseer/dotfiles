#!/bin/bash

killall -q waybar
pkill -f ~/.config/waybar/scripts

while pgrep -x waybar > /dev/null; do sleep 1; done

waybar
