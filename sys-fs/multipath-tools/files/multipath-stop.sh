# /lib/rcscripts/addons/lvm-stop.sh
# $Header: /var/cvsroot/gentoo-x86/sys-fs/multipath-tools/files/multipath-stop.sh,v 1.1 2008/06/20 23:57:19 robbat2 Exp $

dm_in_proc() {
	local retval=0
	for x in devices misc ; do
		grep -qs 'device-mapper' /proc/${x}
		retval=$((${retval} + $?))
	done
	return ${retval}
}

# Stop LVM2
if [ -x /sbin/multipath -a dm_in_proc ]; then
	ebegin "Shutting down Multipath devices"
	/sbin/multipath -v0 -F >/dev/null
	retval=$?
	eend $retval "Failed to shut down Multipath devices"
fi

# vim:ts=4
