#!/sbin/runscript
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lm_sensors/files/sensord-4-init.d,v 1.1 2012/12/28 00:00:03 flameeyes Exp $

CONFIG=/etc/sensors3.conf

depend() {
	need localmount
	use logger lm_sensors
}

command=/usr/sbin/sensorsd
command_arguments="--config-file ${CONFIG} ${SENSORSD_OPTIONS}"
pidfile=/var/run/sensorsd.pid

start_pre() {
	if [ ! -f ${CONFIG} ]; then
		eerror "Configuration file ${CONFIG} not found"
		return 1
	fi
}
