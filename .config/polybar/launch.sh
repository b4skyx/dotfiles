#!/bin/bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get network Interface
export DEFAULT_NETWORK_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)

# Load on second monitor if connected
external_monitor=$(xrandr --query | grep 'HDMI-1-2')
if [[ $external_monitor = HDMI-1-2\ connected* ]]; then
	polybar -c ~/.config/polybar/config.ini secondary &
fi

## Load bar on primary monitor
polybar -c ~/.config/polybar/config.ini main &

