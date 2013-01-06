# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-neomagic/xf86-video-neomagic-1.2.5.ebuild,v 1.5 2012/10/15 14:23:28 chithanh Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="Neomagic video driver"
KEYWORDS="amd64 ia64 x86 ~x86-fbsd"
IUSE=""

RDEPEND="<x11-base/xorg-server-1.12.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xproto"
