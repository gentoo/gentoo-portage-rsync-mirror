# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-geode/xf86-video-geode-2.11.15.ebuild,v 1.2 2014/02/24 20:55:01 chithanh Exp $

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

PATCHES=(
	"${FILESDIR}"/${P}-xf86Modes-include.patch
	"${FILESDIR}"/${P}-xf86Modes-include2.patch
)

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable ztv)
	)
	xorg-2_pkg_setup
}
