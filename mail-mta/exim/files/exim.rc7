#!/sbin/runscript
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/exim/files/exim.rc7,v 1.4 2012/02/28 04:03:55 idl0r Exp $

extra_started_commands="reload"

depend() {
	need logger
	use antivirus net
	provide mta
}

start() {
	ebegin "Starting ${SVCNAME}"
	start-stop-daemon --start --exec /usr/sbin/exim --pidfile /var/run/${SVCNAME}.pid -- -C /etc/exim/${SVCNAME}.conf ${EXIM_OPTS:--bd -q15m}
	eend $?
}

stop() {
	ebegin "Stopping ${SVCNAME}"
	start-stop-daemon --stop --pidfile /var/run/${SVCNAME}.pid --name exim
	eend $?
}

reload() {
	ebegin "Reloading ${SVCNAME}"
	start-stop-daemon --signal HUP --pidfile /var/run/${SVCNAME}.pid --name exim
	eend $?
}
