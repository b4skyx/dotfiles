#!/bin/bash
while :; do
    bat="$(cat /sys/class/power_supply/BAT0/capacity)"
    bat_state="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | tr -d "[:space:]" | cut -c 7-)"
    if [ "$bat" -lt 20 ]; then
        bati=""
    elif [ "$bat" -ge "20" ] && [ "$bat" -lt "40" ]; then
        bati=""
    elif [ "$bat" -ge "40" ] && [ "$bat" -lt "60" ]; then
        bati=""
    elif [ "$bat" -ge "60" ] && [ "$bat" -lt "90" ]; then
        bati=""
    elif [ "$bat" -eq "100" ]; then
        bati=""
    fi
    case "$bat_state" in
        charging)
            bat="$bat%"
            bati=""
            ;;
        *)
            bat="${bat}%"
            ;;
    esac
    echo "${bati} $bat"
    sleep 120
done
