#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/spread/files/spread.init.d,v 1.1 2006/10/06 12:48:29 caleb Exp $
# $Id: spread.init.d,v 1.1 2006/10/06 12:48:29 caleb Exp $

depend() {
  need net
}

start() {
  ebegin "Starting Spread Daemon"
  start-stop-daemon --start --quiet --background --make-pidfile --pidfile /var/run/spread.pid --exec /usr/sbin/spread &
  eend $?
}

stop() {
  ebegin "Stopping Spread"
  start-stop-daemon --stop --pidfile /var/run/spread.pid
  eend $?
}
