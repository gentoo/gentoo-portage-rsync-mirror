#!/sbin/runscript
# Copyright 1999-2008 Gentoo Foundation
# This shell script enables automated check-ins with Smolt
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/smolt/files/smolt-init.d,v 1.1 2009/02/05 21:24:36 bangert Exp $

lockfile=/var/lock/subsys/smolt
uuidfile=/etc/smolt/hw-uuid

depend() {
	use hald
}

start() {
	ebegin "Enabling monthly Smolt check-in"
	if ! [ -f "$uuidfile" ]; then
		einfo "  Generating UUID"
		cat /proc/sys/kernel/random/uuid > "$uuidfile"
	fi
	touch "$lockfile" 
	eend $? "Failed to enable automated check-in"
}

stop() {
	ebegin "Disabling monthly Smolt update"
	rm "$lockfile" 2> /dev/null 
	eend $? "Failed to disable automated check-in"
}
