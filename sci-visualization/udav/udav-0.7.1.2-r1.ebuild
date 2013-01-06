# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/udav/udav-0.7.1.2-r1.ebuild,v 1.2 2012/08/04 17:55:35 bicatali Exp $

EAPI=4

LANGS="ru"

inherit qt4-r2

DESCRIPTION="Universal Data Array Visualization"
HOMEPAGE="http://udav.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
	sci-libs/hdf5
	=sci-libs/mathgl-1*[hdf5,gsl,qt4]
	x11-libs/qt-core:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-desktopfile.patch"
	"${FILESDIR}/${P}-pro.patch"
)

src_prepare() {
	qt4-r2_src_prepare
	if ! use linguas_ru ; then
		sed -e '/udav_ru.qm$/d' -i src/src.pro || die "sed failed"
	fi
}

src_install() {
	qt4-r2_src_install

	dosym /usr/share/icons/hicolor/64x64/apps/${PN}.png \
		/usr/share/pixmaps/${PN}.png
}
