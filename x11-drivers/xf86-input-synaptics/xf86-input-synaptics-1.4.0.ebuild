# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-synaptics/xf86-input-synaptics-1.4.0.ebuild,v 1.6 2012/03/29 14:44:54 chithanh Exp $

EAPI=4

inherit linux-info xorg-2

DESCRIPTION="Driver for Synaptics touchpads"
HOMEPAGE="http://cgit.freedesktop.org/xorg/driver/xf86-input-synaptics/"

KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="
	<x11-base/xorg-server-1.11.99
	>=x11-libs/libXi-1.2
	>=x11-libs/libXtst-1.1.0"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	>=x11-proto/recordproto-1.14"

DOCS=( "README" )

pkg_postinst() {
	xorg-2_pkg_postinst
	# Just a friendly warning
	if ! linux_config_exists \
			|| ! linux_chkconfig_present INPUT_EVDEV; then
		echo
		ewarn "This driver requires event interface support in your kernel"
		ewarn "  Device Drivers --->"
		ewarn "    Input device support --->"
		ewarn "      <*>     Event interface"
		echo
	fi
}
