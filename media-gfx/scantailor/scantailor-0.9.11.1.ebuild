# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/scantailor/scantailor-0.9.11.1.ebuild,v 1.1 2012/03/26 03:09:45 radhermit Exp $

EAPI=4
inherit cmake-utils eutils virtualx

DESCRIPTION="A interactive post-processing tool for scanned pages"
HOMEPAGE="http://scantailor.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 GPL-3 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="opengl"

RDEPEND=">=media-libs/libpng-1.2.43
	>=media-libs/tiff-3.9.4
	sys-libs/zlib
	virtual/jpeg
	x11-libs/libXrender
	x11-libs/qt-gui:4
	opengl? ( x11-libs/qt-opengl:4 )"
DEPEND="${RDEPEND}
	dev-libs/boost"

src_configure() {
	mycmakeargs=(
		-DCOMPILER_FLAGS_OVERRIDDEN=ON
		$(cmake-utils_use_enable opengl)
	)

	cmake-utils_src_configure
}

src_test() {
	cd "${CMAKE_BUILD_DIR}" || die
	Xemake test
}

src_install() {
	cmake-utils_src_install

	newicon resources/appicon.svg ${PN}.svg
	make_desktop_entry ${PN} "Scan Tailor"
}
