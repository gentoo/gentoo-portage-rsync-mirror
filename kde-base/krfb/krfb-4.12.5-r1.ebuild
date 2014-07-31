# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krfb/krfb-4.12.5-r1.ebuild,v 1.1 2014/07/31 20:46:59 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="VNC-compatible server to share KDE desktops"
HOMEPAGE="http://www.kde.org/applications/system/krfb/"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug telepathy"

DEPEND="
	>=net-libs/libvncserver-0.9.9
	sys-libs/zlib
	virtual/jpeg:0
	!aqua? (
		x11-libs/libX11
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXtst
	)
	telepathy? ( >=net-libs/telepathy-qt-0.9 )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-CVE-2014-4607-unbundle-libvncserver.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with telepathy TelepathyQt4)
	)

	kde4-base_src_configure
}
