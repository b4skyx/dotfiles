#!/bin/bash

check_mus() {
	if pgrep -x "cmus" >/dev/null 2>&1; then
		meta="$(cmus-remote -Q)"
		status="$(echo "$meta" | grep "status ")"
		status=${status/status /}
		title="$(echo "$meta" | grep "tag title ")"
		if [[ "${status/status /}" == "stopped" ]]; then
			echo " Stopped"
		else
			echo " ${status^}: ${title/tag title /}"
		fi
	else
		echo " Not Playing"
	fi
	sleep infinity & pid=$!
	wait
}

update(){
	kill $pid
	check_mus
}

trap 'update' USR1
check_mus
