#!/sbin/runscript
# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/opensm/files/opensm.init.d,v 1.3 2015/02/11 04:45:41 bircoph Exp $

depend() {
    need openib
    after net    # ip net seems to be needed to perform management.
}

prog=/usr/sbin/opensm

start() {
    ebegin "Starting OpenSM Infiniband Subnet Manager"
    start-stop-daemon --start --background --exec $prog -- $OSM_OPTIONS
    eend $?
}

stop() {
    ebegin "Stopping OpenSM Infiniband Subnet Manager"
    start-stop-daemon --stop --exec $prog
    eend $?
}

