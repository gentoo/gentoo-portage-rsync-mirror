# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-osdteletext/files/rc-addon-v3.sh,v 1.1 2014/01/12 21:33:10 hd_brummy Exp $
#
# rc-addon-script for plugin osdteletext
#
# Joerg Bornkessel <hd_brummy@gentoo.org>
# Matthias Schwarzott <zzam@gentoo.org>

: ${OSDTELETEXT_TMPFS:=yes}
: ${OSDTELETEXT_SIZE:=20}
: ${OSDTELETEXT_DIR:=/var/cache/vdr/osdteletext}
: ${OSDTELETEXT_STORETOPTEXT:=no}

plugin_pre_vdr_start() {
	add_plugin_param "-d ${OSDTELETEXT_DIR}"
	add_plugin_param "-n ${OSDTELETEXT_SIZE}"

	if [ "${OSDTELETEXT_STORETOPTEXT}" = "yes" ]; then
		add_plugin_param "-t"
	fi

	if [ "${OSDTELETEXT_TMPFS}" = "yes" ]; then
		## test on mountet TMPFS
		if /bin/mount | /bin/grep -q ${OSDTELETEXT_DIR} ; then
			:
		else
			einfo_level2 mounting videotext dir ${OSDTELETEXT_DIR}
			sudo /bin/mount -t tmpfs -o size=${OSDTELETEXT_SIZE}m,uid=vdr,gid=vdr tmpfs ${OSDTELETEXT_DIR}
		fi
	fi
}

plugin_post_vdr_stop() {
	if [ "${OSDTELETEXT_TMPFS}" = "yes" ]; then
		if /bin/mount | /bin/grep -q ${OSDTELETEXT_DIR} ; then
			einfo_level2 unmounting videotext dir ${OSDTELETEXT_DIR}
			sudo /bin/umount ${OSDTELETEXT_DIR}
		fi
	fi
}
