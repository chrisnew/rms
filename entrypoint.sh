#!/usr/bin/env bash

mkdir -p /var/run/dbus

dbus-daemon --system --nofork  &
pulseaudio --system --disallow-exit &

counter=0
limit=24

if [ ! -f /data/callees.txt ]; then
	echo "ERROR: /data/callees.txt missing"
	exit 1
fi

while true; do
	while read -r number || [[ -n "$number" ]]; do
		echo "calling $number"

		(( sleep 28; echo q; echo q; sleep 2 ) | pjsua --local-port=$(($RANDOM % 30000 + 2000)) --config-file /data/pjsua.cfg "sip:$number@voip.eventphone.de" ) &

		counter=$(($counter+1))
		
		if [ "$counter" -eq "$limit" ]; then
			echo "waiting for calls"
			wait
			counter=0
		fi
	done < /data/callees.txt

	if [ "$counter" -eq "0" ]; then
		echo "waiting for rest"
		wait
	fi
done

echo "finished"

exit 0
