#!/sbin/runscript
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/logitechmediaserver-bin/files/logitechmediaserver.init.d,v 1.2 2012/04/28 23:47:34 lavajoe Exp $

# These fit the Logitech Media Server ebuild and so shouldn't need to be
# changed; user-servicable parts go in /etc/conf.d/logitechmediaserver.
lms=logitechmediaserver
rundir=/var/run/${lms}
logdir=/var/log/${lms}
optdir=/opt/${lms}
vardir=/var/lib/${lms}
pidfile=${rundir}/${lms}.pid
cachedir=${vardir}/cache
prefsdir=/etc/${lms}
lmsuser=${lms}
lmsbin=${optdir}/slimserver.pl

depend() {
	need net
}

start_pre() {
	checkpath -q -d -o ${lmsuser}:${lmsuser} -m 0770 "${rundir}"
}

start() {
	ebegin "Starting Logitech Media Server"

	cd /
	start-stop-daemon \
		--start --exec ${lmsbin} \
		--pidfile ${pidfile} \
		--user ${lmsuser} \
		--background \
		-- \
		--quiet \
		--pidfile=${pidfile} \
		--cachedir=${cachedir} \
		--prefsdir=${prefsdir} \
		--logdir=${logdir} \
		--audiodir=${LMS_MUSIC_DIR} \
		--playlistdir=${LMS_PLAYLISTS_DIR} \
		${LMS_OPTS}

	eend $? "Failed to start Logitech Media Server"
}

stop() {
	ebegin "Stopping Logitech Media Server"
	start-stop-daemon --retry 10 --stop --pidfile ${pidfile}
	eend $? "Failed to stop Logitech Media Server"
}
