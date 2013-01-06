# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wifi-radar/wifi-radar-2.0.8.ebuild,v 1.4 2011/12/04 14:38:05 hwoarang Exp $

inherit eutils versionator

MY_PV="$(get_version_component_range 1-2)"
MY_PL="$(get_version_component_range 3)"
MY_PL="s0${MY_PL}"
MY_PV="${MY_PV}.${MY_PL}"

DESCRIPTION="WiFi Radar is a Python/PyGTK2 utility for managing WiFi profiles."
HOMEPAGE="http://wifi-radar.berlios.de/"
SRC_URI="mirror://berlios/wifi-radar/wifi-radar-${MY_PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="svg"

RDEPEND=">=dev-python/pygtk-2.16.0-r1
	>=net-wireless/wireless-tools-29
	|| ( net-misc/dhcpcd net-misc/dhcp net-misc/pump )"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install ()
{
	dosbin wifi-radar
	dosed "s:/etc/wpa_supplicant.conf:/etc/wpa_supplicant/wpa_supplicant.conf:" /usr/sbin/wifi-radar
	dobin wifi-radar.sh
	if use svg; then
		doicon pixmaps/wifi-radar.svg
		make_desktop_entry wifi-radar.sh "WiFi Radar" wifi-radar Network
	else
		doicon pixmaps/wifi-radar.png
		make_desktop_entry wifi-radar.sh "WiFi Radar" wifi-radar Network
	fi

	doman man/man1/wifi-radar.1 man/man5/wifi-radar.conf.5

	cd docs
	dodoc BUGS CREDITS DEVELOPER_GUIDELINES HISTORY README README.WPA-Mini-HOWTO.txt TODO
}

pkg_postinst()
{
	einfo "Remember to edit configuration file /etc/wifi-radar.conf to suit your needs..."
	echo
	einfo "To use wifi-radar with a normal user (with sudo) add:"
	einfo "%users   ALL = /usr/sbin/wifi-radar"
	einfo "in your /etc/sudoers. Also, find the line saying:"
	einfo "Defaults      env_reset"
	einfo "and modify it as follows:"
	einfo "Defaults      env_keep=DISPLAY"
	echo
	einfo "Then launch wifi-radar.sh"
	echo
}
