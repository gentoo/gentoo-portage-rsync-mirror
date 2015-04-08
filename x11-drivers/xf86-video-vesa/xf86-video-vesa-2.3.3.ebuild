# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-vesa/xf86-video-vesa-2.3.3.ebuild,v 1.5 2013/10/08 05:06:57 ago Exp $

EAPI=5
inherit xorg-2

DESCRIPTION="Generic VESA video driver"
KEYWORDS="-* alpha amd64 ia64 x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99
	>=x11-libs/libpciaccess-0.12.901"
DEPEND="${RDEPEND}"
