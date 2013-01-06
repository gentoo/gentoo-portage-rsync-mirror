#!/bin/sh

if /etc/init.d/polipo --quiet status; then
	#Expire old cached objects
	kill -USR1 $(cat /var/run/polipo.pid)
	sleep 1
	nice -n 15 su -s "/bin/sh" -c "polipo -x" polipo > /dev/null
	kill -USR2 $(cat /var/run/polipo.pid)
fi
