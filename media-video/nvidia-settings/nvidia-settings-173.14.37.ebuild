# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-settings/nvidia-settings-173.14.37.ebuild,v 1.1 2013/04/20 20:43:55 idl0r Exp $

EAPI=4

inherit eutils multilib toolchain-funcs

MY_P="${PN}-1.0"

DESCRIPTION="NVIDIA Linux X11 Settings Utility"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="ftp://download.nvidia.com/XFree86/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
IUSE="examples"

COMMON_DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm[static-libs]
	x11-libs/gtk+:2
	x11-libs/gdk-pixbuf[X]
	media-libs/mesa
	x11-libs/pango[X]
	x11-libs/libXv
	x11-libs/libXrandr
	dev-libs/glib:2"

RDEPEND="=x11-drivers/nvidia-drivers-173.14*[-tools]
	${COMMON_DEPEND}"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-173.14.31-Makefile.patch"
}

src_compile() {
	einfo "Building libXNVCtrl..."
	emake -C src/libXNVCtrl/ clean # NVidia ships pre-built archives :(
	emake -C src/libXNVCtrl/ CC="$(tc-getCC)" RANLIB="$(tc-getRANLIB)" libXNVCtrl.a

	einfo "Building nvidia-settings..."
	emake  LOCAL_CFLAGS="" CC="$(tc-getCC)" LD="$(tc-getLD)"
}

src_install() {
	emake prefix="${D}/usr" STRIP="$(type -P true)" install

	insinto /usr/$(get_libdir)
	doins src/libXNVCtrl/libXNVCtrl.a

	insinto /usr/include/NVCtrl
	doins src/libXNVCtrl/*.h

#	doicon doc/${PN}.png
	make_desktop_entry ${PN} "NVIDIA X Server Settings" ${PN} Application

	dodoc doc/*.txt

	if use examples; then
		docinto examples/
		dodoc samples/*.c
		dodoc samples/README
	fi
}
