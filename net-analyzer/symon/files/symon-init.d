#!/sbin/runscript
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the 2-clause BSD license
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/symon/files/symon-init.d,v 1.3 2012/09/13 07:07:53 pinkbyte Exp $

opts="${opts} reload"

depend() {
	after bootmisc
	need localmount net
	use logger
}

reload() {
	ebegin "Reloading symon"
	start-stop-daemon --stop --pidfile /var/run/symon.pid \
		--exec /usr/sbin/symon --oknodo --signal HUP
	eend $?
}

start() {
	ebegin "Starting symon"
	start-stop-daemon --start --exec /usr/sbin/symon -- -u
	eend $?
}

stop() {
	ebegin "Stopping symon"
	start-stop-daemon --stop --pidfile /var/run/symon.pid
	eend $?
}
