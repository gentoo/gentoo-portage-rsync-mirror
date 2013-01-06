# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-streamdev/files/rc-addon-0.5.0.sh,v 1.1 2011/01/17 17:07:34 hd_brummy Exp $
#
# rc-addon-script for plugin streamdev-server
#
# Joerg Bornkessel <hd_brummy@g.o>

plugin_pre_vdr_start() {

		: ${STREAMDEV_REMUX_SCRIPT:=/usr/share/vdr/streamdev/externremux.sh}

		add_plugin_param "-r ${STREAMDEV_REMUX_SCRIPT}"
}
