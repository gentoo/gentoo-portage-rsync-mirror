# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-sisusb/xf86-video-sisusb-0.9.6-r1.ebuild,v 1.2 2013/09/29 11:13:15 ago Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="SiS USB video driver"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.6"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-remove-mibstore_h.patch
)
