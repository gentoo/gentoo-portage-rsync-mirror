# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freecad/freecad-0.13.1830.ebuild,v 1.2 2013/05/09 08:36:38 xmw Exp $

EAPI=5

PYTHON_DEPEND=2

inherit eutils multilib fortran-2 python cmake-utils

DESCRIPTION="QT based Computer Aided Design application"
HOMEPAGE="http://www.freecadweb.org/"
SRC_URI="mirror://sourceforge/free-cad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-cpp/eigen:3
	dev-games/ode
	dev-libs/boost
	dev-libs/libf2c
	dev-libs/libspnav[X]
	dev-libs/xerces-c[icu]
	dev-python/PyQt4[svg]
	dev-python/pivy
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	dev-qt/qtxmlpatterns:4
	media-libs/SoQt
	media-libs/coin[doc]
	sci-libs/gts
	sci-libs/opencascade
	sys-libs/zlib
	virtual/glu"
DEPEND="${RDEPEND}
	>=dev-lang/swig-2.0.4-r1:0"

# http://bugs.gentoo.org/show_bug.cgi?id=352435
# http://www.gentoo.org/foundation/en/minutes/2011/20110220_trustees.meeting_log.txt
RESTRICT="bindist mirror"

pkg_setup() {
	fortran-2_pkg_setup
	python_set_active_version 2
}

src_prepare() {
	einfo remove bundled libs
	rm -rf src/3rdParty

	epatch "${FILESDIR}"/${P}-remove-qt3-support.patch
}

src_configure() {
	local my_occ_env=${EROOT}etc/env.d/50opencascade
	if [ -e "${EROOT}etc//env.d/51opencascade" ] ; then
		my_occ_env=${EROOT}etc/env.d/51opencascade
	fi
	export CASROOT=$(sed -ne '/^CASROOT=/{s:.*=:: ; p}' $my_occ_env)

	local mycmakeargs=(
		-DOCC_INCLUDE_DIR="${CASROOT}"/inc
		-DOCC_INCLUDE_PATH="${CASROOT}"/inc
		-DOCC_LIBRARY="${CASROOT}"/lib/libTKernel.so
		-DOCC_LIBRARY_DIR="${CASROOT}"/lib
		-DOCC_LIB_PATH="${CASROOT}"/lib
		-DCOIN3D_INCLUDE_DIR="${EROOT}"usr/include/coin
		-DCOIN3D_LIBRARY="${EROOT}"usr/$(get_libdir)/libCoin.so
		-DSOQT_LIBRARY="${EROOT}"usr/$(get_libdir)/libSoQt.so
		-DSOQT_INCLUDE_PATH="${EROOT}"usr/include/coin
		-DCMAKE_BINARY_DIR="${EROOT}"usr/bin
		-DCMAKE_INSTALL_PREFIX="${EROOT}"usr/$(get_libdir)/${P}
	)
	cmake-utils_src_configure
	ewarn "${P} will be built against opencascade version ${CASROOT}"
}

src_install() {
	cmake-utils_src_install

	prune_libtool_files

	dodoc README.Linux ChangeLog.txt
}
