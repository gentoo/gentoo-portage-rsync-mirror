# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/virtualgl/virtualgl-2.3.2.ebuild,v 1.3 2013/02/05 17:38:27 pacho Exp $

EAPI="4"
inherit cmake-utils multilib

DESCRIPTION="Run OpenGL applications remotely with full 3D hardware acceleration"
HOMEPAGE="http://www.virtualgl.org/"

MY_PN="VirtualGL"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}/${PV}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1 wxWinLL-3.1 FLTK"
KEYWORDS="~amd64 ~x86"
IUSE="multilib ssl"

RDEPEND="ssl? ( dev-libs/openssl )
	media-libs/libjpeg-turbo
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXv
	multilib? ( app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-opengl )
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}"

CMAKE_VERBOSE=1
build32_dir="${WORKDIR}/${P}_build32"

src_prepare() {
	# Use /var/lib, bug #428122
	sed -e "s#/etc/opt#/var/lib#g" -i doc/unixconfig.txt doc/index.html doc/advancedopengl.txt \
		server/vglrun server/vglgenkey server/vglserver_config || die

	default
}

src_configure() {
	# Configure 32bit version on multilib
	use amd64 && use multilib && (
		einfo "Configuring 32bit libs..."

		local ABI=x86
		local CFLAGS="${CFLAGS--O2 -march=native -pipe} -m32"
		local CXXFLAGS="${CFLAGS}"
		local LDFLAGS="${LDFLAGS} -m32"
		local BUILD_DIR="${build32_dir}"

		mycmakeargs=(
			$(cmake-utils_use ssl VGL_USESSL)
			-DVGL_DOCDIR=/usr/share/doc/"${P}"
			-DVGL_LIBDIR=/usr/$(get_libdir)
			-DTJPEG_INCLUDE_DIR=/usr/include
			-DTJPEG_LIBRARY=/usr/$(get_libdir)/libturbojpeg.so
			-DCMAKE_LIBRARY_PATH=/usr/lib32
			-DVGL_FAKELIBDIR=/usr/fakelib/32
		)
		cmake-utils_src_configure

		einfo "Configuring 64bit libs..."
	)

	# Configure native version
	mycmakeargs=(
		$(cmake-utils_use ssl VGL_USESSL)
		-DVGL_DOCDIR=/usr/share/doc/"${P}"
		-DVGL_LIBDIR=/usr/$(get_libdir)
		-DTJPEG_INCLUDE_DIR=/usr/include
		-DTJPEG_LIBRARY=/usr/$(get_libdir)/libturbojpeg.so
		-DCMAKE_LIBRARY_PATH=/usr/lib64
		-DVGL_FAKELIBDIR=/usr/fakelib/64
	)
	cmake-utils_src_configure
}

src_compile() {
	# Make 32bit version on multilib
	use amd64 && use multilib && (
		einfo "Building 32bit libs..."
		local BUILD_DIR="${build32_dir}"
		cmake-utils_src_compile

		einfo "Building 64bit libs..."
	)

	# Make native version
	cmake-utils_src_compile
}

src_install() {
	# Install 32bit version on multilib
	use amd64 && use multilib && (
		einfo "Installing 32bit libs..."
		local BUILD_DIR="${build32_dir}"
		cmake-utils_src_install

		einfo "Installing 64bit libs..."
	)

	# Install native version
	cmake-utils_src_install

	# Make config dir
	dodir /var/lib/VirtualGL
	fowners root:video /var/lib/VirtualGL
	fperms 0750 /var/lib/VirtualGL
	newinitd "${FILESDIR}/vgl.initd-r1" vgl
	newconfd "${FILESDIR}/vgl.confd-r1" vgl

	# Rename glxinfo to vglxinfo to avoid conflict with x11-apps/mesa-progs
	mv "${D}"/usr/bin/{,v}glxinfo || die
}
