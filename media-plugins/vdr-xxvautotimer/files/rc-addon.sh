# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-xxvautotimer/files/rc-addon.sh,v 1.1 2008/03/22 18:27:10 hd_brummy Exp $
#
# rc-addon-script for plugin xxvautotimer
#
# Joerg Bornkessel <hd_brummy@gentoo.org>

: ${XXV_CONF_DIR:=/etc/xxv/xxvd.cfg}

plugin_pre_vdr_start() {

  add_plugin_param "-f ${XXV_CONF_DIR}"

}
