# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/avogadro/avogadro-1.0.3-r1.ebuild,v 1.4 2013/02/23 17:28:06 ago Exp $

EAPI=3

PYTHON_DEPEND="python? 2:2.5"

inherit base cmake-utils eutils python

DESCRIPTION="Advanced molecular editor that uses Qt4 and OpenGL"
HOMEPAGE="http://avogadro.openmolecules.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="+glsl python sse2"

RDEPEND="
	>=sci-chemistry/openbabel-2.2.3
	>=x11-libs/qt-gui-4.5.3:4
	>=x11-libs/qt-opengl-4.5.3:4
	x11-libs/gl2ps
	glsl? ( >=media-libs/glew-1.5.0 )
	python? (
		>=dev-libs/boost-1.35
		>=dev-libs/boost-1.35.0-r5[python]
		dev-python/numpy
		dev-python/sip
	)"
DEPEND="${RDEPEND}
	dev-cpp/eigen:2"

PATCHES=(
	"${FILESDIR}"/1.0.1-gl2ps.patch
)

pkg_setup() {
	python_set_active_version 2
}

src_configure() {
	local mycmakeargs=(
		"-DENABLE_THREADGL=FALSE"
		"-DENABLE_RPATH=OFF"
		"-DENABLE_UPDATE_CHECKER=OFF"
		"-DQT_MKSPECS_DIR=${EPREFIX}/usr/share/qt4/mkspecs"
		"-DQT_MKSPECS_RELATIVE=share/qt4/mkspecs"
		$(cmake-utils_use_enable glsl)
		$(cmake-utils_use_with sse2 SSE2)
		$(cmake-utils_use_enable python)
	)

	cmake-utils_src_configure
}
