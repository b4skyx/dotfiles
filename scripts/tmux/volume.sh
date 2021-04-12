#!/bin/bash

volume() {
		#vol="$(pacmd list-sinks | grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/%//g')"
		vol="$(pactl list sinks | grep -m 1 "Volume:" | awk '{print $5}' | sed 's/%//g')"

		if [ "$vol" -ge "0" ] && [ "$vol" -lt "30" ]; then
			voli=""
		elif [ "$vol" -ge "30" ] && [ "$vol" -lt "60" ]; then
		    voli="奔"
		elif [ "$vol" -ge "60" ] && [ "$vol" -lt "90" ]; then
		    voli="墳"
		elif [ "$vol" -ge "90" ] && [ "$vol" -le "100" ]; then
		    voli="墳"
		else
		    voli="墳"
		fi

		echo "$voli ${vol}%"
	sleep infinity & pid=$!
	wait
}

update() {
	kill $pid
	volume
}

trap 'update' USR1
volume
