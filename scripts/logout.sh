#!/bin/bash

chosen=$(echo -e "Logout\nReboot\nShutdown" | rofi -show drun -show-icons -dmenu -i)

if [[ $chosen = "Logout" ]]; then
    bspc quit
elif [[ $chosen = "Shutdown" ]]; then
	systemctl poweroff
elif [[ $chosen = "Reboot" ]]; then
	systemctl reboot
fi
