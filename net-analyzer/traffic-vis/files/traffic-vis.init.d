#!/sbin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traffic-vis/files/traffic-vis.init.d,v 1.4 2011/12/04 11:24:35 hwoarang Exp $

depend() {
	need net
}

start() {
	ebegin "Starting traffic-vis"
	start-stop-daemon --start --quiet --exec /usr/sbin/traffic-collector -- --pid-file /var/run/traffic-collector.pid --interface $TRAFFIC_VIS_INTERFACE --summary-file $TRAFFIC_VIS_FILE $TRAFFIC_VIS_OPTIONS
	eend $? "Failed to start traffic-vis"
}

stop() {
	ebegin "Stopping traffic-vis"
	start-stop-daemon --stop --quiet --pidfile /var/run/traffic-collector.pid
	eend $? "Failed to stop traffic-vis"
}
