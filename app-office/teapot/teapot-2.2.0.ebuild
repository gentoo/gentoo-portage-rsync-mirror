# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/teapot/teapot-2.2.0.ebuild,v 1.3 2011/12/10 14:18:53 ssuominen Exp $

EAPI=4
inherit cmake-utils flag-o-matic

DESCRIPTION="A powerful spreadhseet program"
HOMEPAGE="http://www.syntax-k.de/projekte/teapot/"
SRC_URI="http://www.syntax-k.de/projekte/teapot/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc fltk"

RDEPEND="sys-libs/ncurses
	fltk? ( >=x11-libs/fltk-1.3.0:1 )"
DEPEND="${RDEPEND}
	doc? (
		app-office/lyx
		dev-tex/latex2html
		dev-tex/pgf
		dev-texlive/texlive-fontsrecommended
	)"

PATCHES=(
	"${FILESDIR}"/${P}-doc-dir.patch
	"${FILESDIR}"/${P}-helpfile.patch
)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable doc HELP)
		-DPF=${PF}
	)

	if use fltk; then
		mycmakeargs+=(
			-DFLTK_USE_FILE=/usr/share/cmake/Modules/FLTKConfig.cmake
			-DFLTK_DIR=/usr/share/cmake/Modules
			-DFLTK_FLUID_EXECUTABLE=/usr/bin/fluid
		)
		append-cxxflags -I/usr/include/fltk-1
		append-ldflags -L/usr/$(get_libdir)/fltk-1
	fi

	cmake-utils_src_configure
}
