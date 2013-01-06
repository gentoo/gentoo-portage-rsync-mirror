# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-qxl/xf86-video-qxl-0.0.17-r1.ebuild,v 1.1 2012/08/08 13:33:10 chithanh Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="QEMU QXL paravirt video driver"

KEYWORDS="~amd64 ~x86"
IUSE="xspice"

RDEPEND="xspice? ( app-emulation/spice )
	x11-base/xorg-server[-minimal]"
DEPEND="${RDEPEND}
	x11-proto/xf86dgaproto
	>=app-emulation/spice-protocol-0.8.1"

PATCHES=(
	"${FILESDIR}"/${P}-xorg-server-1.13.patch
)

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable xspice)
	)
}
