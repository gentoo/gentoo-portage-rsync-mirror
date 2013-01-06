# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/massxpert/massxpert-1.7.6.ebuild,v 1.6 2012/07/26 15:12:06 kensington Exp $

EAPI=2

inherit base eutils flag-o-matic cmake-utils

DESCRIPTION="A software suite to predict/analyze mass spectrometric data on (bio)polymers."
HOMEPAGE="http://massxpert.org/wiki/"
SRC_URI="http://download.tuxfamily.org/massxpert/source/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	x11-libs/qt-gui:4[accessibility]
	x11-libs/qt-svg:4
	x11-libs/qt-xmlpatterns:4
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXfixes
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libX11
	sys-libs/zlib
	media-libs/freetype
	media-libs/fontconfig
	media-libs/nas
	media-libs/libpng
	dev-libs/libxml2:2"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/"${P}"
CMAKE_IN_SOURCE_BUILD="true"

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

src_compile() {
	sed -i \
		-e "s:/lib/:/$(get_libdir)/:g" \
		-e "s:ADD_DEFINITIONS (-Wall -Werror):ADD_DEFINITIONS (-Wall):" \
		CMakeLists.txt || \
		die "404. File not found while sedding."

	tc-export CC CXX LD
	mycmakeargs="-D__LIB=$(get_libdir)"

	if use amd64 ; then
		append-flags -fPIC
	fi

	cmake-utils_src_compile
}
