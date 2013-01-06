# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-settings/nvidia-settings-290.10.ebuild,v 1.10 2012/05/05 14:37:26 idl0r Exp $

EAPI=4

inherit eutils multilib toolchain-funcs

DESCRIPTION="NVIDIA Linux X11 Settings Utility"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="ftp://download.nvidia.com/XFree86/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
IUSE="examples"

COMMON_DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm
	x11-libs/gtk+:2
	x11-libs/gdk-pixbuf[X]
	media-libs/mesa
	x11-libs/pango[X]
	x11-libs/libXv
	x11-libs/libXrandr
	dev-libs/glib:2"

RDEPEND="=x11-drivers/nvidia-drivers-2*
	|| ( >=x11-drivers/nvidia-drivers-295.33 <x11-drivers/nvidia-drivers-295.33[-gtk] )
	${COMMON_DEPEND}"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto"

src_prepare() {
	epatch "${FILESDIR}/0001-Makefile-improvements.patch"
	epatch "${FILESDIR}/0002-Build-libNVCtrl-with-PIC.patch"

	# The PM does it for us
	sed -i -e 's:^\(MANPAGE_GZIP ?=\) 1:\1 0:' Makefile || die
}

src_compile() {
	einfo "Building libXNVCtrl..."
	emake -C src/libXNVCtrl/ clean # NVidia ships pre-built archives :(
	emake -C src/libXNVCtrl/ CC="$(tc-getCC)" RANLIB="$(tc-getRANLIB)" libXNVCtrl.a

	einfo "Building nvidia-settings..."
	emake  CC="$(tc-getCC)" LD="$(tc-getLD)" STRIP_CMD="$(type -P true)" NV_VERBOSE=1
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install

	insinto /usr/$(get_libdir)
	doins src/libXNVCtrl/libXNVCtrl.a

	insinto /usr/include/NVCtrl
	doins src/libXNVCtrl/*.h

#	doicon doc/${PN}.png # Installed through nvidia-drivers
	make_desktop_entry ${PN} "NVIDIA X Server Settings" ${PN} Application

	# bug 412569 - Installed through nvidia-drivers
	rm -rf "${D}"/usr/share/man

	dodoc doc/*.txt

	if use examples; then
		docinto examples/
		dodoc samples/*.c
		dodoc samples/README
	fi
}
