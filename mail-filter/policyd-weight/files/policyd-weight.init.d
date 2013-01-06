#!/sbin/runscript
opts="${opts} reload"

depend(){
	before postfix
	need net
}

start(){
	ebegin "Starting policyd-weight"
	/usr/lib/postfix/policyd-weight start
	eend $?
}

stop(){
	ebegin "Stopping policyd-weight"
	/usr/lib/postfix/policyd-weight -k stop
	eend $?
}

reload(){
	ebegin "Reloading policyd-weight"
	/usr/lib/postfix/policyd-weight reload
	eend $?
}
