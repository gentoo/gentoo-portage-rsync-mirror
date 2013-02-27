# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnsfb/libnsfb-9999.ebuild,v 1.2 2013/02/27 08:00:54 xmw Exp $

EAPI=5

inherit eutils git-2 multilib toolchain-funcs

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libnsfb/"
SRC_URI="mirror://gentoo/netsurf-buildsystem-0_p20120717.tar.gz"
EGIT_REPO_URI="git://git.netsurf-browser.org/libnsfb.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="sdl static-libs vnc xcb"

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

src_unpack() {
	default
	git-2_src_unpack
	mv build "${S}" || die
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.0.2-unused.patch

	#patch buildsystem from SRC_URI
	epatch "${FILESDIR}"/${PN}-0.0.2-autodetect.patch

	sed -e "/^CCOPT :=/s:=.*:=:" \
		-i build/makefiles/Makefile.gcc || die
	sed -e '/^CFLAGS/s: -g : :' \
		-e "/^INSTALL_ITEMS/s: /lib: /$(get_libdir):g" \
		-e "s/\$(eval \$(call pkg_config_get_variable,NSFB_XCBPROTO_VERSION,xcb,xcbproto_version))/NSFB_XCBPROTO_VERSION := $(pkg-config --variable=xcbproto_version xcb)/" \
		-e "1iNSSHARED=${S}/build" \
		-e "1iNSBUILD=${S}/build/makefiles" \
		-i Makefile || die
	sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
		-i ${PN}.pc.in || die

	echo "Q  := " >> Makefile.config
	echo "CC := $(tc-getCC)" >> Makefile.config
	echo "AR := $(tc-getAR)" >> Makefile.config

	echo "NSFB_SDL_AVAILABLE := $(usex sdl)" >> Makefile.config
	echo "NSFB_VNC_AVAILABLE := $(usex vnc)" >> Makefile.config
	echo "NSFB_XCB_AVAILABLE := $(usex xcb)" >> Makefile.config
	echo "NSFB_XCB_UTIL_AVAILABLE := $(usex xcb)" >> Makefile.config
}

src_compile() {
	emake COMPONENT_TYPE=lib-shared
	use static-libs && \
		emake COMPONENT_TYPE=lib-static
}

src_test() {
	emake COMPONENT_TYPE=lib-shared test
	use static-libs && \
		emake COMPONENT_TYPE=lib-static test
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr COMPONENT_TYPE=lib-shared install
	use static-libs && \
		emake DESTDIR="${D}" PREFIX=/usr COMPONENT_TYPE=lib-static install
	dodoc usage
}
