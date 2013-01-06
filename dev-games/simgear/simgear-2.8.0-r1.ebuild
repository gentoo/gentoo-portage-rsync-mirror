# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/simgear/simgear-2.8.0-r1.ebuild,v 1.4 2012/12/09 15:10:08 ago Exp $

EAPI=4

inherit eutils cmake-utils

DESCRIPTION="Development library for simulation games"
HOMEPAGE="http://www.simgear.org/"
SRC_URI="http://mirrors.ibiblio.org/pub/mirrors/simgear/ftp/Source/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
SLOT="0"
IUSE="debug jpeg subversion test"

COMMON_DEPEND="
	dev-libs/expat
	>=dev-games/openscenegraph-3.0.1
	media-libs/freealut
	media-libs/openal
	sys-libs/zlib
	virtual/opengl
	jpeg? ( virtual/jpeg )
	subversion? (
		dev-libs/apr
		dev-vcs/subversion
	)
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.37
"
RDEPEND="${COMMON_DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-unbundle-expat.patch"
)

DOCS=(AUTHORS ChangeLog NEWS README Thanks)

src_configure() {
	local mycmakeargs=(
		-DENABLE_RTI=OFF
		-DSIMGEAR_HEADLESS=OFF
		-DSIMGEAR_SHARED=ON
		-DSYSTEM_EXPAT=ON
		$(cmake-utils_use jpeg JPEG_FACTORY)
		$(cmake-utils_use_enable subversion LIBSVN)
		$(cmake-utils_use_enable test TESTS)
	)
	cmake-utils_src_configure
}
