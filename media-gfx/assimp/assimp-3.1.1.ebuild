# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/assimp/assimp-3.1.1.ebuild,v 1.2 2014/10/23 11:14:42 aballier Exp $

EAPI=5

inherit cmake-utils versionator

DESCRIPTION="Importer library to import assets from 3D files"
HOMEPAGE="http://assimp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="BSD"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+boost samples static tools"
SLOT="0"

DEPEND="
	boost? ( dev-libs/boost )
	samples? ( x11-libs/libX11 virtual/opengl media-libs/freeglut )
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build samples ASSIMP_SAMPLES) \
		$(cmake-utils_use_build tools ASSIMP_TOOLS) \
		$(cmake-utils_use_build static STATIC_LIB) \
		$(cmake-utils_use_enable !boost BOOST_WORKAROUND)
	)

	cmake-utils_src_configure
}