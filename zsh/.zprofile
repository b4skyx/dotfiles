export XDG_CONFIG_HOME='/home/abi/.config'
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	sx
fi
