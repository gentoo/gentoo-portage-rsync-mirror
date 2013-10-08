# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-tdfx/xf86-video-tdfx-1.4.5-r1.ebuild,v 1.7 2013/10/08 05:06:44 ago Exp $

EAPI=5
XORG_DRI=dri

inherit xorg-2

DESCRIPTION="3Dfx video driver"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-fbsd"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable dri)
	)
}

PATCHES=(
	"${FILESDIR}"/${P}-remove-mibstore_h.patch
)
