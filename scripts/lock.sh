#!/usr/bin/env bash

# Ain't much but honest work ;D
# Author: b4skyx
# Motivation: barbarossa93

CLOCK_FONT="Sarasa UI HC"
FONT="Sarasa Mono K"

quote="$(shuf -n 1 ~/.quotes)"
weather="$(cat /tmp/weather)"
lock() {
        i3lock -n -c 00000044 -e --f \
                --ind-pos="w/2:h-24"\
                --radius=7 --ring-width=8 \
                --ring-color=31363b00 --ringver-color=474f5400 --ringwrong-color=474f5400 \
                --inside-color=474f54 --insidever-color=d39bb600 --insidewrong-color=d39bb600\
                --line-uses-inside \
                --time-str="%I:%M %p" --time-pos="w/2:h/2-70" \
                --time-color=bfddb2 --timeoutline-color=868686  --time-font="$CLOCK_FONT:style=Italic" --time-size=64 \
                --date-pos="tx:ty+42"\
                --date-color=b3cfa7 --date-font="$FONT:style=Bold" --date-size=24 \
                --greeter-text="\"$quote\"" \
                --greeter-pos="w/2:h/2+18"\
                --greeter-color=d39bb6 --greeter-font="$FONT" --greeter-size=24 \
                --keylayout 2 --layout-pos="18:h-18" --layout-color=999f93 --layout-align=1\
                --layout-font="Sarasa Mono K" \
                --verif-text="Matching Passphrase.." --verif-pos="w/2:h-18" \
                --verif-color=999f93 --verif-font="$FONT" --verif-size=14 \
                --wrong-text="Invalid Passphrase!" --wrong-pos="w/2:h-18" \
                --wrong-color=d76e6e --wrong-font="$FONT" --wrong-size=14 \
                --noinput-text="No Input"
}

status=$(playerctl status || true)

#genbg
if [ "$status" == "Playing" ]; then
	playerctl pause
fi
dunstctl set-paused true

if pgrep -x rofi; then
	killall rofi
fi
lock
if [ "$status" == "Playing" ]; then
	playerctl play
fi
dunstctl set-paused false
