# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-i128/xf86-video-i128-1.3.4.ebuild,v 1.4 2011/02/12 19:23:18 armin76 Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="Number 9 I128 video driver"

KEYWORDS="amd64 ia64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xproto"
