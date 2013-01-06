# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-savage/xf86-video-savage-2.3.4-r1.ebuild,v 1.5 2012/08/26 19:50:03 armin76 Exp $

EAPI=4
XORG_DRI=dri
inherit xorg-2

DESCRIPTION="S3 Savage video driver"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~amd64-fbsd ~x86-fbsd"

IUSE="dri"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	>=x11-proto/xextproto-7.0.99.1"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable dri)
	)
	xorg-2_pkg_setup
}
