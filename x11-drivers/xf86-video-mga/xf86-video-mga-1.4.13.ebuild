# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-mga/xf86-video-mga-1.4.13.ebuild,v 1.7 2012/09/06 13:21:23 chithanh Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="Matrox video driver"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="dri"

RDEPEND="<x11-base/xorg-server-1.12.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xproto
	dri? ( x11-proto/xf86driproto
			x11-proto/glproto
			>=x11-libs/libdrm-2 )"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable dri)"
}
