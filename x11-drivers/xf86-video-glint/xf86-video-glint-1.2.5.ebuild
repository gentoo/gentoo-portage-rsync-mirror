# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-glint/xf86-video-glint-1.2.5.ebuild,v 1.5 2011/02/14 23:56:23 xarthisius Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="GLINT/Permedia video driver"

KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-fbsd"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xproto
	dri? ( x11-proto/xf86driproto
			>=x11-libs/libdrm-2
			x11-proto/glproto )"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable dri)"
}
