# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/openmesh/openmesh-2.0_rc5.ebuild,v 1.4 2012/06/08 02:55:55 zmedico Exp $

EAPI="3"
inherit eutils flag-o-matic cmake-utils

MY_PN="OpenMesh"
MY_PV="${PV/_rc/-RC}"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

DESCRIPTION="A generic and efficient data structure for representing and manipulating polygonal meshes"
HOMEPAGE="http://www.openmesh.org/"
SRC_URI="http://openmesh.org/fileadmin/${PN}-files/${MY_PV/-RC/RC}/${MY_PN}-${MY_PV}.tar.bz2"

# See COPYING.EXCEPTIONS
LICENSE="LGPL-3 as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 debug static-libs"

RDEPEND="qt4? ( x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	media-libs/freeglut )"
DEPEND="${RDEPEND}"

src_prepare() {
	# Fix libdir and remove rpath.
	cd "${S}"
	sed -i \
		-e "s|\(set (ACG_PROJECT_LIBDIR \"\).*|\1$(get_libdir)/\")|" \
		-e "s|\(set (ACG_PROJECT_PLUGINDIR \"\)lib\(.*\)|\1$(get_libdir)\2|" \
		-e "s|\(BUILD_WITH_INSTALL_RPATH \)1|\1 0|" \
		-e "s|\(SKIP_BUILD_RPATH\) 0|\1 1|" \
		-e '/^ *INSTALL_RPATH/d' \
		cmake/ACGCommon.cmake || die
}

src_configure() {
	if use debug; then
		CMAKE_BUILD_TYPE=Debug
	else
		CMAKE_BUILD_TYPE=Release
		append-cppflags -DNDEBUG
	fi
	mycmakeargs="$(cmake-utils_use_build "qt4" "APPS")"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if ! use static-libs; then
		# No way to set this in the build system as of 2.0_rc5
		rm -f "${D}"/usr/$(get_libdir)/*.a \
			|| die "Failed to remove static libraries."
	fi
	cd "${S}"
	dodoc LICENSE/* README CHANGELOG || die
}
