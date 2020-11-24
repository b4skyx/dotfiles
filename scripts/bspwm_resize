#!/bin/bash

[ "$#" -eq 3 ] || { echo "Needs exactly three arguments."; exit 1; }

motion="$1"
direction="$2"
size="$3"

if [ "$motion" = 'expand' ]; then
	# These expand the window's given side
	case "$direction" in
		north) bspc node -z top 0 -"$size" ;;
		east) bspc node -z right "$size" 0 ;;
		south) bspc node -z bottom 0 "$size" ;;
		west) bspc node -z left -"$size" 0 ;;
	esac
else
	# These contract the window's given side
	case "$direction" in
		north) bspc node -z top 0 "$size" ;;
		east) bspc node -z right -"$size" 0 ;;
		south) bspc node -z bottom 0 -"$size" ;;
		west) bspc node -z left "$size" 0 ;;
	esac
fi
