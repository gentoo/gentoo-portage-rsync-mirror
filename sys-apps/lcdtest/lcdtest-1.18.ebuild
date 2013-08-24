# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lcdtest/lcdtest-1.18.ebuild,v 1.2 2013/08/24 15:40:39 maekke Exp $

EAPI=5

inherit scons-utils toolchain-funcs base

DESCRIPTION="Displays test patterns to spot dead/hot pixels on LCD screens"
HOMEPAGE="http://www.brouhaha.com/~eric/software/lcdtest/"
SRC_URI="http://www.brouhaha.com/~eric/software/lcdtest/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=media-libs/libsdl-1.2.7-r2
	>=media-libs/sdl-image-1.2.3-r1
	>=media-libs/sdl-ttf-2.0.9
"
RDEPEND="${DEPEND}
	media-fonts/liberation-fonts
"
PATCHES=( "${FILESDIR}/${PV}-build-system.patch" )

src_prepare() {
	base_src_prepare
	sed -i -e \
		"s|/usr/share/fonts/liberation/|/usr/share/fonts/liberation-fonts/|" \
		src/lcdtest.c || die
}

src_configure() {
	tc-export CC
	myesconsargs=(
		--prefix="${EPREFIX}/usr"
	)
}

src_compile() {
	escons
}

src_install() {
	escons --buildroot="${D}" install
	dodoc README
}
