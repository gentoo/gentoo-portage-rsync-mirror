#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lm_sensors/files/sensord-3-init.d,v 1.1 2009/11/29 13:13:08 bangert Exp $

CONFIG=/etc/sensors3.conf

depend() {
	need logger
	use lm_sensors
}

checkconfig() {
	if [ ! -f ${CONFIG} ]; then
		eerror "Configuration file ${CONFIG} not found"
		return 1
	fi
}

start() {
	checkconfig || return 1

	ebegin "Starting sensord"
	start-stop-daemon --start --exec /usr/sbin/sensord \
		-- --config-file ${CONFIG} ${SENSORD_OPTIONS}
	eend ${?}
}

stop() {
	ebegin "Stopping sensord"
	start-stop-daemon --stop --pidfile /var/run/sensord.pid
	eend ${?}
}
