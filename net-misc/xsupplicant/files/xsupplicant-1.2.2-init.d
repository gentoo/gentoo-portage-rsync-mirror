#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/xsupplicant/files/xsupplicant-1.2.2-init.d,v 1.1 2006/01/13 14:47:59 brix Exp $

depend() {
	before net
}

checkconfig() {
	if [ ! -f /etc/xsupplicant.conf ]; then
		eerror "Configuration file /etc/xsupplicant.conf not found"
		return 1
	fi
}

start() {
	checkconfig || return 1

	ebegin "Starting xsupplicant"

	for IFACE in $INTERFACES; do
		ebegin " ${IFACE}"

		eval ARGS_IFACE=\"\$\{ARGS_$IFACE\}\"

		start-stop-daemon --start --quiet --background --exec /usr/sbin/xsupplicant \
			 -- -i${IFACE} -c/etc/xsupplicant.conf ${ARGS} ${ARGS_IFACE}
		eend ${?}
	done
}

stop() {
        ebegin "Stopping xsupplicant"

        start-stop-daemon --stop --quiet --exec /usr/sbin/xsupplicant
        eend ${?}
}

