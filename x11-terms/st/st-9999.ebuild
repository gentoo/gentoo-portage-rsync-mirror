# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/st/st-9999.ebuild,v 1.13 2015/03/12 14:16:15 xmw Exp $

EAPI=5
inherit eutils git-r3 multilib savedconfig toolchain-funcs

DESCRIPTION="simple terminal implementation for X"
HOMEPAGE="http://st.suckless.org/"
EGIT_REPO_URI="git://git.suckless.org/st"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS=""
IUSE="savedconfig"

RDEPEND="media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft"
DEPEND="${RDEPEND}
	sys-libs/ncurses
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/xproto"

src_prepare() {
	epatch_user

	sed -e '/^CFLAGS/s:[[:space:]]-Wall[[:space:]]: :' \
		-e '/^CFLAGS/s:[[:space:]]-O[^[:space:]]*[[:space:]]: :' \
		-e '/^LDFLAGS/{s:[[:space:]]-s[[:space:]]: :}' \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-i config.mk || die
	sed -e '/@echo/!s:@::' \
		-i Makefile || die
	tc-export CC

	restore_config config.h
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	tic -s -o "${ED}"/usr/share/terminfo st.info || die
	dodoc TODO

	make_desktop_entry ${PN} simpleterm utilities-terminal 'System;TerminalEmulator;' ''

	save_config config.h
}

pkg_postinst() {
	if ! [[ "${REPLACING_VERSIONS}" ]]; then
		elog "Please ensure a usable font is installed, like"
		elog "    media-fonts/corefonts"
		elog "    media-fonts/dejavu"
		elog "    media-fonts/urw-fonts"
	fi
}
