# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/qtoctave/qtoctave-0.10.1.ebuild,v 1.4 2013/03/02 23:25:44 hwoarang Exp $

EAPI="2"

CMAKE_IN_SOURCE_BUILD=1
inherit eutils cmake-utils

PID=2054

DESCRIPTION="QtOctave is a Qt4 front-end for Octave"
HOMEPAGE="http://forja.rediris.es/projects/csl-qtoctave/"
SRC_URI="http://forja.rediris.es/frs/download.php/${PID}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.6:4
	>=dev-qt/qtsvg-4.6:4"

RDEPEND="${DEPEND}
	>=sci-mathematics/octave-3.2.0"

DOCS="readme.txt leeme.txt"

src_prepare() {
	sed -i -e 's/Categories=/Categories=Development;/' \
		qtoctave/src/config_files/qtoctave.desktop || die 'sed failed.'
}

src_configure() {
	mycmakeargs=(-DCMAKE_SKIP_RPATH:BOOL=YES )
	cmake-utils_src_configure
}
