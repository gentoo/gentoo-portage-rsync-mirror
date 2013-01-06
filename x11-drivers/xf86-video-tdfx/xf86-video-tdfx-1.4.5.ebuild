# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-tdfx/xf86-video-tdfx-1.4.5.ebuild,v 1.7 2012/12/30 14:51:16 ago Exp $

EAPI=4
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
