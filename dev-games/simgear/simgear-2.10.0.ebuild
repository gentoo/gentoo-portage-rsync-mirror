# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/simgear/simgear-2.10.0.ebuild,v 1.1 2013/02/20 21:21:42 reavertm Exp $

EAPI=5

inherit eutils cmake-utils

DESCRIPTION="Development library for simulation games"
HOMEPAGE="http://www.simgear.org/"
SRC_URI="http://mirrors.ibiblio.org/pub/mirrors/simgear/ftp/Source/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="debug jpeg subversion test"

COMMON_DEPEND="
	dev-libs/expat
	>=dev-games/openscenegraph-3.0.1
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
	>=dev-libs/boost-1.44
"
RDEPEND="${COMMON_DEPEND}"

DOCS=(AUTHORS ChangeLog NEWS README Thanks)

src_configure() {
	local mycmakeargs=(
		-DENABLE_RTI=OFF
		-DENABLE_SOUND=ON
		-DSIMGEAR_HEADLESS=OFF
		-DSIMGEAR_SHARED=ON
		-DSYSTEM_EXPAT=ON
		$(cmake-utils_use jpeg JPEG_FACTORY)
		$(cmake-utils_use_enable subversion LIBSVN)
		$(cmake-utils_use_enable test TESTS)
	)
	cmake-utils_src_configure
}
