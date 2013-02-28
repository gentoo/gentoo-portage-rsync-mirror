# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnsfb/libnsfb-9999.ebuild,v 1.3 2013/02/28 07:39:57 xmw Exp $

EAPI=5

inherit eutils git-2 multilib toolchain-funcs

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libnsfb/"
SRC_URI="mirror://gentoo/netsurf-buildsystem-0_p20120717.tar.gz"
EGIT_REPO_URI="git://git.netsurf-browser.org/libnsfb.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
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
	git-2_src_unpack
	mv build "${S}" || die
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.0.2-unused.patch

	#patch buildsystem from SRC_URI
	epatch "${FILESDIR}"/${PN}-0.0.2-autodetect.patch

	netsurf_src_prepare

	sed -e '/^CFLAGS/s: -g : :' \
		-e "s/\$(eval \$(call pkg_config_get_variable,NSFB_XCBPROTO_VERSION,xcb,xcbproto_version))/NSFB_XCBPROTO_VERSION := $(pkg-config --variable=xcbproto_version xcb)/" \
		-e "1iNSSHARED=${S}/build" \
		-e "1iNSBUILD=${S}/build/makefiles" \
		-i Makefile || die
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
