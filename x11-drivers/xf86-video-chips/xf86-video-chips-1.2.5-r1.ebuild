# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-chips/xf86-video-chips-1.2.5-r1.ebuild,v 1.4 2013/10/06 11:43:29 ago Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="Chips and Technologies video driver"

KEYWORDS="amd64 ia64 ppc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

PATCHES=(
	"${FILESDIR}"/${P}-remove-mibstore_h.patch
)
