# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gebabbel/gebabbel-0.4.ebuild,v 1.2 2012/08/01 15:57:59 jlec Exp $

EAPI=4

MY_P=${P/g/G}

inherit eutils qt4-r2

DESCRIPTION="QT-Frontend to load and convert gps tracks with gpsbabel"
HOMEPAGE="http://gebabbel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-Src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-gui:4[accessibility]
"
RDEPEND="${DEPEND}
	sci-geosciences/gpsbabel
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.3-gcc45.patch
)

S=${WORKDIR}/${MY_P}

src_prepare() {
	base_src_prepare
	# do not mess with cflags
	sed \
		-e "/QMAKE_CXXFLAGS/s:=.*$:= ${CXXFLAGS}:g" \
		-i *.pro || die
}

src_install() {
	dobin bin/${PN}
	dodoc CHANGELOG CREDITS
}
