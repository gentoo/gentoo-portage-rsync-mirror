# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-geode/xf86-video-geode-2.11.15.ebuild,v 1.1 2013/10/13 23:52:53 chithanh Exp $

EAPI=5
inherit xorg-2

DESCRIPTION="AMD Geode GX2 and LX video driver"

KEYWORDS="~x86"
IUSE="ztv"

RDEPEND=""
DEPEND="${RDEPEND}
	ztv? (
		sys-kernel/linux-headers
	)"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable ztv)
	)
	xorg-2_pkg_setup
}
