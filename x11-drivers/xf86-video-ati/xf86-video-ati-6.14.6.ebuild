# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-6.14.6.ebuild,v 1.3 2012/11/11 22:50:47 chithanh Exp $

EAPI=4

XORG_DRI=always
inherit xorg-2

DESCRIPTION="ATI video driver"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libdrm-2.4.36[video_cards_radeon]"
DEPEND="${RDEPEND}"

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		--enable-dri
		--enable-kms
		--enable-exa
	)
}
