#!/sbin/runscript

depend() {
	need cups avahi-daemon
}

start() {
	ebegin "Starting cups-browsed"
	start-stop-daemon --start --quiet --exec /usr/sbin/cups-browsed
	eend $?
}

stop() {
	ebegin "Stopping cups-browsed"
	start-stop-daemon --stop --quiet --exec /usr/sbin/cupsd
	eend $?
}
