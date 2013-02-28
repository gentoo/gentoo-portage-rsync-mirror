# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnsfb/libnsfb-0.0.2.ebuild,v 1.3 2013/02/28 07:39:57 xmw Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libnsfb/"
SRC_URI="http://download.netsurf-browser.org/netsurf/releases/source-full/netsurf-2.9-full-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="debug sdl static-libs vnc xcb"

RDEPEND="sdl? ( media-libs/libsdl )
	vnc? ( net-libs/libvncserver )
	xcb? ( x11-libs/libxcb
		x11-libs/xcb-util
		x11-libs/xcb-util-image
		x11-libs/xcb-util-keysyms )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# we don't allow access to /dev/fb0
RESTRICT="test"

pkg_setup(){
	netsurf_src_prepare() {
		sed -e "/^CCOPT :=/s:=.*:=:" \
			-e "/^CCNOOPT :=/s:=.*:=:" \
			-e "/^CCDBG :=/s:=.*:=:" \
			-i build/makefiles/Makefile.{gcc,clang}
		sed -e "/^INSTALL_ITEMS/s: /lib: /$(get_libdir):g" \
			-i Makefile || die
		sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
			-i ${NETSURF_PKGCONFIG:-${PN}}.pc.in || die
	}
	netsurf_src_configure() {
		echo "Q := " >> Makefile.config
		echo "CC := $(tc-getCC)" >> Makefile.config
		echo "AR := $(tc-getAR)" >> Makefile.config
	}

	netsurf_make() {
		emake COMPONENT_TYPE=lib-shared BUILD=$(usex debug debug release) "$@"
		use static-libs && \
			emake COMPONENT_TYPE=lib-static BUILD=$(usex debug debug release) "$@"
	}
}

src_unpack() {
	default
	mv netsurf-2.9/${P} . || die
	rm -r netsurf-2.9 || die
}

src_prepare() {
	#backported from vcs
	epatch "${FILESDIR}"/${P}-xcb-fix.patch

	epatch "${FILESDIR}"/${P}-unused.patch
	epatch "${FILESDIR}"/${P}-autodetect.patch

	netsurf_src_prepare
}

src_configure() {
	netsurf_src_configure

	echo "NSFB_SDL_AVAILABLE := $(usex sdl)" >> Makefile.config
	echo "NSFB_VNC_AVAILABLE := $(usex vnc)" >> Makefile.config
	echo "NSFB_XCB_AVAILABLE := $(usex xcb)" >> Makefile.config
	echo "NSFB_XCB_UTIL_AVAILABLE := $(usex xcb)" >> Makefile.config
}

src_compile() {
	netsurf_make
}

src_test() {
	netsurf_make test
}

src_install() {
	netsurf_make DESTDIR="${D}" PREFIX=/usr install

	dodoc usage
}
