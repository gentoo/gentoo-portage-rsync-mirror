#!/sbin/runscript
# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lm_sensors/files/sensord-4-init.d,v 1.2 2013/01/31 15:37:50 flameeyes Exp $

CONFIG=/etc/sensors3.conf

depend() {
	need localmount
	use logger lm_sensors
}

pidfile=/run/sensord.pid
command=/usr/sbin/sensord
command_arguments="--config-file ${CONFIG} ${SENSORSD_OPTIONS} --pid-file ${pidfile}"

start_pre() {
	if [ ! -f ${CONFIG} ]; then
		eerror "Configuration file ${CONFIG} not found"
		return 1
	fi
}
