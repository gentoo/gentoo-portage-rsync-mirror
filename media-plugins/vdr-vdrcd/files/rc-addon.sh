# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vdrcd/files/rc-addon.sh,v 1.2 2007/04/17 09:48:04 zzam Exp $
#
# rc-addon plugin-startup-skript for vdr-vdrcd
#

: ${VDRCD_PLUGIN_MOUNT:=/usr/bin/mount-vdrcd.sh}
: ${VDRCD_DRIVE:=/dev/cdrom}

plugin_pre_vdr_start() {

	local VDRCD_DRV

	for VDRCD_DRV in ${VDRCD_DRIVE}; do
		add_plugin_param "-c ${VDRCD_DRV}"
	done

	add_plugin_param "-m ${VDRCD_PLUGIN_MOUNT}"
				
}
