# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jrtplib/jrtplib-3.9.1.ebuild,v 1.1 2013/02/22 15:15:50 pinkbyte Exp $

EAPI="5"

CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils

DESCRIPTION="Object-oriented RTP library written in C++"
HOMEPAGE="http://research.edm.uhasselt.be/~jori/page/index.php?n=CS.Jrtplib"
SRC_URI="http://research.edm.uhasselt.be/jori/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND=">=dev-libs/jthread-1.3.0[static-libs?]"
DEPEND="${RDEPEND}"

DOCS=( ChangeLog README.TXT TODO )

src_prepare() {
	# do not build examples - they are not installed into live filesystem
	sed -i -e '/add_subdirectory(examples)/d' CMakeLists.txt || die 'disabling examples compilation failed'
	# do not build static library, if it is not requested
	if ! use static-libs; then
		sed -i -e '/jrtplib-static/d' src/CMakeLists.txt || die 'sed on src/CMakeLists.txt failed'
	fi
}
