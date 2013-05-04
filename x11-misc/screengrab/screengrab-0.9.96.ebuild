# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/screengrab/screengrab-0.9.96.ebuild,v 1.1 2013/05/04 08:51:23 hwoarang Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Qt application for getting screenshots"
HOMEPAGE="http://code.google.com/p/screengrab-qt/"
# Mirror the tarball because upstream failed to provide a proper way to get it
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libX11
	dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

src_prepare() {
	# Install docs into the right dir, but skip the license.
	# Respect CXXFLAGS.
	sed -i -e "/SG_DOCDIR/s:screengrab:${PF}:" \
		-e "/CMAKE_CXX_FLAGS/s:\"): ${CXXFLAGS}&:" \
		CMakeLists.txt || die
}
