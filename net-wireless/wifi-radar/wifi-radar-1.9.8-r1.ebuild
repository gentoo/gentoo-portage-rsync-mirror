# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wifi-radar/wifi-radar-1.9.8-r1.ebuild,v 1.7 2011/04/15 21:36:38 ulm Exp $

inherit eutils

DESCRIPTION="WiFi Radar is a Python/PyGTK2 utility for managing WiFi profiles."
HOMEPAGE="http://wifi-radar.systemimager.org/"
SRC_URI="http://wifi-radar.systemimager.org/pub/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="svg"

RDEPEND=">=dev-python/pygtk-2.6.1
	>=net-wireless/wireless-tools-27-r1
	|| ( net-misc/dhcpcd net-misc/dhcp net-misc/pump )"

src_unpack()
{
	unpack ${A}
	cd "${S}"
	epatch \
		debian/patches/01atheros.dpatch \
		debian/patches/02wpa_supp_args.dpatch
}

src_install ()
{
	dosbin wifi-radar
	dosed "s:/etc/conf.d:/etc:g" /usr/sbin/wifi-radar
	dobin wifi-radar.sh
	insinto /etc; doins wifi-radar.conf
	if use svg; then
		doicon pixmaps/wifi-radar.svg
		make_desktop_entry wifi-radar.sh "WiFi Radar" wifi-radar Network
	else
		doicon pixmaps/wifi-radar.png
		make_desktop_entry wifi-radar.sh "WiFi Radar" wifi-radar Network
	fi
	doman wifi-radar.1 wifi-radar.conf.5
	dodoc CHANGE.LOG README TODO
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
