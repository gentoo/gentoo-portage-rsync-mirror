# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vdrrip/files/rc-addon.sh,v 1.1 2006/10/13 20:11:50 zzam Exp $
#
# rc-addon plugin-startup-skript for vdr-vdrrip
#

plugin_pre_vdr_start() {
	# The PlugIn has to find mplayer and mencoder.
	add_plugin_param "--MPlayer=/usr/bin/mplayer"
	add_plugin_param "--MEncoder=/usr/bin/mencoder"
}

