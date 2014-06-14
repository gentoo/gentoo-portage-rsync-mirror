# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/virtualgl/virtualgl-2.3.3.ebuild,v 1.2 2014/06/14 10:14:34 phajdan.jr Exp $

EAPI=5
inherit cmake-multilib multilib systemd

DESCRIPTION="Run OpenGL applications remotely with full 3D hardware acceleration"
HOMEPAGE="http://www.virtualgl.org/"

MY_PN="VirtualGL"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}/${PV}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1 wxWinLL-3.1 FLTK"
KEYWORDS="~amd64 x86"
IUSE="ssl"

RDEPEND="
	ssl? ( dev-libs/openssl )
	media-libs/libjpeg-turbo
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXv
	amd64? ( abi_x86_32? (
		|| (
			media-libs/libjpeg-turbo[abi_x86_32]
			app-emulation/emul-linux-x86-baselibs[-abi_x86_32]
		)
		|| (
			(
				x11-libs/libX11[abi_x86_32]
				x11-libs/libXext[abi_x86_32]
				x11-libs/libXv[abi_x86_32]
			)
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32]
		)
		|| (
			(
				virtual/glu[abi_x86_32]
				virtual/opengl[abi_x86_32]
			)
			app-emulation/emul-linux-x86-opengl[-abi_x86_32]
		)
	) )
	virtual/glu
	virtual/opengl
"
DEPEND="${RDEPEND}"

src_prepare() {
	# Use /var/lib, bug #428122
	sed -e "s#/etc/opt#/var/lib#g" -i doc/unixconfig.txt doc/index.html doc/advancedopengl.txt \
		server/vglrun server/vglgenkey server/vglserver_config || die

	default
}

src_configure() {
	abi_configure() {
		local mycmakeargs=(
			$(cmake-utils_use ssl VGL_USESSL)
			-DVGL_DOCDIR=/usr/share/doc/"${P}"
			-DTJPEG_INCLUDE_DIR=/usr/include
			-DVGL_LIBDIR=/usr/$(get_libdir)
			-DTJPEG_LIBRARY=/usr/$(get_libdir)/libturbojpeg.so
			-DCMAKE_LIBRARY_PATH=/usr/$(get_libdir)
			-DVGL_FAKELIBDIR=/usr/fakelib/${ABI}
		)
		cmake-utils_src_configure
	}
	multilib_parallel_foreach_abi abi_configure
}

src_install() {
	cmake-multilib_src_install

	# Make config dir
	dodir /var/lib/VirtualGL
	fowners root:video /var/lib/VirtualGL
	fperms 0750 /var/lib/VirtualGL
	newinitd "${FILESDIR}/vgl.initd-r2" vgl
	newconfd "${FILESDIR}/vgl.confd-r1" vgl

	exeinto /usr/libexec
	doexe "${FILESDIR}/vgl-helper.sh"
	systemd_dounit "${FILESDIR}/vgl.service"

	# Rename glxinfo to vglxinfo to avoid conflict with x11-apps/mesa-progs
	mv "${D}"/usr/bin/{,v}glxinfo || die
}
