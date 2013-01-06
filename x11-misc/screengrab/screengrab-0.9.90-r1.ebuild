# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/screengrab/screengrab-0.9.90-r1.ebuild,v 1.3 2012/06/30 21:58:11 jdhore Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Qt application for getting screenshots"
HOMEPAGE="http://code.google.com/p/screengrab-qt/"
SRC_URI="http://screengrab-qt.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/qt-core:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_prepare() {
	# Install docs into the right dir, but skip the license.
	# Respect CXXFLAGS.
	sed -i -e "/LICENSE.txt/d" \
		-e "/SG_DOCDIR/s:share/doc/screengrab:${PF}:" \
		-e "/CMAKE_CXX_FLAGS/s:\"): ${CXXFLAGS}&:" \
		CMakeLists.txt || die
}
