# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freecad/freecad-0.12.5284-r2.ebuild,v 1.6 2013/03/02 21:35:36 hwoarang Exp $

EAPI=4
PYTHON_DEPEND=2

inherit base multilib fortran-2 flag-o-matic python cmake-utils

MY_P="freecad-${PV}"
MY_PD="FreeCAD-${PV}"

DESCRIPTION="QT based Computer Aided Design application"
HOMEPAGE="http://sourceforge.net/apps/mediawiki/free-cad/"
SRC_URI="mirror://sourceforge/free-cad/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-cpp/eigen:3
	dev-games/ode
	dev-libs/boost
	dev-libs/libf2c
	dev-libs/xerces-c
	dev-python/pivy
	dev-python/PyQt4[svg]
	media-libs/coin
	media-libs/SoQt
	>=sci-libs/opencascade-6.3-r3
	sci-libs/gts
	sys-libs/zlib
	virtual/glu
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	dev-qt/qtxmlpatterns:4"
DEPEND="${RDEPEND}
	>=dev-lang/swig-2.0.4-r1"

RESTRICT="bindist mirror"
# http://bugs.gentoo.org/show_bug.cgi?id=352435
# http://www.gentoo.org/foundation/en/minutes/2011/20110220_trustees.meeting_log.txt

S="${WORKDIR}/${MY_PD}"

PATCHES=(
	"${FILESDIR}/${P}-gcc46.patch"
	"${FILESDIR}/${P}-removeoldswig.patch"
	"${FILESDIR}/${P}-glu.patch"
	"${FILESDIR}/${P}-nodir.patch"
	"${FILESDIR}/${P}-nopivy.patch"
	"${FILESDIR}/${P}-qt3support.patch"
	"${FILESDIR}/${P}-boost148.patch"
)

pkg_setup() {
	fortran-2_pkg_setup
	python_set_active_version 2
}

src_prepare() {
	base_src_prepare
	append-cxxflags -fpermissive
}

src_configure() {
	local mycmakeargs=(
		-DOCC_INCLUDE_DIR=${CASROOT}/inc
		-DOCC_INCLUDE_PATH=${CASROOT}/inc
		-DOCC_LIBRARY=${CASROOT}/lib/libTKernel.so
		-DOCC_LIBRARY_DIR=${CASROOT}/lib
		-DOCC_LIB_PATH=${CASROOT}/lib
		-DCOIN3D_INCLUDE_DIR=/usr/include/coin
		-DCOIN3D_LIBRARY=/usr/$(get_libdir)/libCoin.so
		-DSOQT_LIBRARY=/usr/$(get_libdir)/libSoQt.so
		-DSOQT_INCLUDE_PATH=/usr/include/coin
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	find "${D}" -name "*.la" -exec rm {} +

	dodoc README.Linux ChangeLog.txt
}
