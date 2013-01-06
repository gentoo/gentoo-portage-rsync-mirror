# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/st/st-0.3.ebuild,v 1.3 2012/11/07 17:48:37 jer Exp $

EAPI=4
inherit savedconfig toolchain-funcs

DESCRIPTION="simple terminal implementation for X"
HOMEPAGE="http://st.suckless.org/"
SRC_URI="http://hg.suckless.org/st/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
"
DEPEND="
	${RDEPEND}
	sys-libs/ncurses
	x11-proto/xextproto
	x11-proto/xproto
"

src_prepare() {
	sed -e '/^CFLAGS/s:[[:space:]]-Wall[[:space:]]: :' \
		-e '/^CFLAGS/s:[[:space:]]-O[^[:space:]]*[[:space:]]: :' \
		-e '/^LDFLAGS/{s:[[:space:]]-s[[:space:]]: :}' \
		-i config.mk || die
	tc-export CC

	restore_config config.h
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install || die
	tic -s -o "${ED}"/usr/share/terminfo st.info || die
	dodoc TODO

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
