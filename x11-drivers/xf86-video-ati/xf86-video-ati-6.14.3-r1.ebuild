# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-6.14.3-r1.ebuild,v 1.1 2012/03/18 23:26:25 chithanh Exp $

EAPI=4

XORG_EAUTORECONF=yes
XORG_DRI=always
inherit xorg-2

DESCRIPTION="ATI video driver"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libdrm[video_cards_radeon]"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-6.14.3-xorg-server-1.12.patch
	"${FILESDIR}"/${PN}-6.14.3-pcitag.patch
)

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		--enable-dri
		--enable-kms
		--enable-exa
	)
}
