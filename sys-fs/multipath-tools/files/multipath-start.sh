# /lib/rcscripts/addons/multipath-start.sh: Setup multipath devices at boot
# $Header: /var/cvsroot/gentoo-x86/sys-fs/multipath-tools/files/multipath-start.sh,v 1.1 2008/06/20 23:57:19 robbat2 Exp $

dm_in_proc() {
	local retval=0
	for x in devices misc ; do
		grep -qs 'device-mapper' /proc/${x}
		retval=$((${retval} + $?))
	done
	return ${retval}
}

# NOTE: Add needed modules for RAID, Multipath etc
#       to /etc/modules.autoload if needed
if [ -z "${CDBOOT}" -a -x /sbin/multipath ] ; then
	if [ -e /proc/modules ] && ! dm_in_proc ; then
		modprobe dm-mod 2>/dev/null
	fi

	if dm_in_proc ; then
		ebegin "Activating Multipath devices"
		/sbin/multipath -v0 >/dev/null
		retval=$?
		eend ${retval} "Failed to activate multipath devices"
	fi
fi

# vim:ts=4
