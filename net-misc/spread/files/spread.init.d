#!/sbin/runscript
# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/spread/files/spread.init.d,v 1.2 2014/03/11 09:50:45 kumba Exp $
# $Id: spread.init.d,v 1.2 2014/03/11 09:50:45 kumba Exp $

depend() {
	need net
}

mkdir_spreadirs() {
	[ -d /var/run/spread ] || mkdir -p /var/run/spread
}

start() {
	ebegin "Starting Spread Daemon"
	mkdir_spreadirs
	start-stop-daemon --start --quiet --background --make-pidfile --pidfile /var/run/spread.pid --exec /usr/sbin/spread &
	eend $?
}

stop() {
	ebegin "Stopping Spread"
	start-stop-daemon --stop --pidfile /var/run/spread.pid
	eend $?
}
