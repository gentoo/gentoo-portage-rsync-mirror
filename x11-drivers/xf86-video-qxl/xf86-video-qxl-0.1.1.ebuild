# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-qxl/xf86-video-qxl-0.1.1.ebuild,v 1.3 2013/12/10 13:23:22 ago Exp $

EAPI=5
inherit xorg-2

DESCRIPTION="QEMU QXL paravirt video driver"

KEYWORDS="amd64 x86"
IUSE="xspice"

RDEPEND="xspice? ( app-emulation/spice )
	x11-base/xorg-server[-minimal]
	>=x11-libs/libdrm-2.4.46"
DEPEND="${RDEPEND}
	x11-proto/xf86dgaproto
	>=app-emulation/spice-protocol-0.12.0"

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable xspice)
	)
	xorg-2_src_configure
}
