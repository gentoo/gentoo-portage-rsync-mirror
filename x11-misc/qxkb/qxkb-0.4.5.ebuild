# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qxkb/qxkb-0.4.5.ebuild,v 1.1 2012/12/25 10:07:36 pesa Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Qt4-based keyboard layout switcher"
HOMEPAGE="http://code.google.com/p/qxkb/"
SRC_URI="http://qxkb.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	x11-libs/libxkbfile
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
"
RDEPEND="${DEPEND}
	x11-apps/setxkbmap
"

src_prepare() {
	sed -i -e 's:../language:${CMAKE_SOURCE_DIR}/language:' \
		CMakeLists.txt || die

	base_src_prepare
}
