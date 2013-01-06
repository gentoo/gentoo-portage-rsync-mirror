# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dvdconvert/files/rc-addon.sh,v 1.2 2007/04/17 12:42:26 zzam Exp $
#
# rc-addon-script for plugin dvdconvert
#
# Joerg Bornkessel <hd_brummy@gentoo.org>

DVDCONVERT_CONF="/usr/share/vdr/dvdconvert/dvdconvert.conf"

plugin_pre_vdr_start() {

add_plugin_param "-c ${DVDCONVERT_CONF}"

}
