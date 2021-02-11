#!/bin/sh

# Usage:
# tabc.sh <tabbed-id> <command>
# Commands:
#    add <window-id> 	- Add window to tabbed
#    remove <window-id> - Remove window from tabbed
#    list		- List all clients of tabbed

TABBED_CONFIG="-c -k -o #2a2d33 -O #d5c4a1 -t #373d41 -T #d5c4a1"

#
# Functions
#

# Get wid of root window
get_root_wid () {
	xwininfo -root | awk '/Window id:/{print $4}'
}

# Get children of tabbed
get_clients () {
	id=$1
	xwininfo -id $id -children | sed -n '/[0-9]\+ \(child\|children\):/,$s/ \+\(0x[0-9a-z]\+\).*/\1/p'
}

# Get class of a wid
get_class () {
	id=$1
	xprop -id $id | sed -n '/WM_CLASS/s/.*, "\(.*\)"/\1/p'
}

#
# Main Program
#

tabbed=$1; shift
cmd=$1; shift
if [ "$(get_class $tabbed)" != "tabbed" ]; then
	# It looks like what supposed to be an id of a tabbed window is not a
	# tabbed.
	if [ $cmd = "add" ]; then
		# But this is the `add` command so lets join booth windows in a
		# new tabbed instance. First start tabbed, add the target window
		# and then proceed to normal `add`.
		sibling=$tabbed
		tabbed=$(tabbed $TABBED_CONFIG -d) && xdotool windowreparent $sibling $tabbed || exit 2
	else
		# For other commands we need tunning tabbed instance
		echo "$tabbed is not an instance of tabbed"
		exit 1
	fi
fi


case $cmd in
	add)
		wid=$1; shift
		xdotool windowreparent $wid $tabbed
		;;
	remove)
		wid=$1
		# When there isn't supplied an id of a window to be removed
		# from tabbed then remove the currently active one.
		test -n "$win" || wid=$(get_clients $tabbed| head -1)
		xdotool windowreparent $wid $(get_root_wid)
		;;
	list)
		get_clients $tabbed
		;;
esac
