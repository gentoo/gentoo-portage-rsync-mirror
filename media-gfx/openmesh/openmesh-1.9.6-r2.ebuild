# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/openmesh/openmesh-1.9.6-r2.ebuild,v 1.6 2011/05/11 20:03:43 angelos Exp $

EAPI="2"
inherit eutils

MY_PN="OpenMesh"
S=${WORKDIR}/${MY_PN}
DESCRIPTION="A generic and efficient data structure for representing and manipulating polygonal meshes"
HOMEPAGE="http://www.openmesh.org/"
SRC_URI="http://www-i8.informatik.rwth-aachen.de/${MY_PN}/downloads/${MY_PN}-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="qt4 debug"

RDEPEND="qt4? ( x11-libs/qt-gui:4
		x11-libs/qt-opengl:4
		media-libs/freeglut )"
DEPEND=">=dev-util/acgmake-1.4
	>=sys-apps/findutils-4.3.0
	${RDEPEND}"

src_prepare() {
	use qt4 || sed -i "s:Apps::" ACGMakefile
	# gcc-4.3 fixs.
	sed -i \
		'N;s,\(OPENMESH_VECTOR_HH )\n\),\1#include <string.h>\n,' \
		Core/Geometry/VectorT_inc.hh || die
	epatch "${FILESDIR}/QGLViewerWidget-hh-gcc-4.3-include-fix.patch" || die
}

src_compile() {
	if use debug; then
		export CXXDEFS="-UNDEBUG -DDEBUG"
	else
		export CXXDEFS="-DNDEBUG -UDEBUG"
	fi
	acgmake -env || die

	# fix insecure runpaths
	TMPDIR="${S}" scanelf -BXRr "${S}" -o /dev/null || die
}

src_install() {
	local l

	for l in $(find "${S}"/{Core,Tools} -name '*.so'); do
		dolib ${l} || die
	done

	# Clean up manually as acgmake doesn't do a decent job.
	find . -name 'ACGMakefile' -delete || die
	find . -name '*.vcproj' -delete || die
	rm -rf $(find "${S}" -type d -name 'Linux_gcc*_env') || die

	dodir /usr/include/${MY_PN}

	cp -a Core "${D}"/usr/include/${MY_PN}
	cp -a Tools "${D}"/usr/include/${MY_PN}
}
