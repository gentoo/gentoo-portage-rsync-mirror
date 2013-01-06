# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-r128/xf86-video-r128-6.8.2-r1.ebuild,v 1.6 2012/08/26 19:48:44 armin76 Exp $

EAPI=4
XORG_DRI=dri
inherit xorg-2

DESCRIPTION="ATI Rage128 video driver"

KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.2"
DEPEND="${RDEPEND}"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable dri)
	)
}
