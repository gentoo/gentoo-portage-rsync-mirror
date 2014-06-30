# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dmenu/dmenu-9999.ebuild,v 1.1 2014/06/30 13:31:15 jer Exp $

EAPI=5
inherit eutils git-r3 savedconfig toolchain-funcs

DESCRIPTION="a generic, highly customizable, and efficient menu for the X Window System"
HOMEPAGE="http://tools.suckless.org/dmenu/"
EGIT_REPO_URI="git://git.suckless.org/dmenu"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="xft xinerama"

RDEPEND="
	x11-libs/libX11
	xft? ( x11-libs/libXft )
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${RDEPEND}
	xft? ( virtual/pkgconfig )
	xinerama? ( virtual/pkgconfig )
"

src_prepare() {
	# Respect our flags
	sed -i \
		-e '/^CFLAGS/{s|=.*|+= -ansi -pedantic -Wall $(INCS) $(CPPFLAGS)|}' \
		-e '/^LDFLAGS/s|= -s|+=|' \
		config.mk || die
	# Make make verbose
	sed -i \
		-e 's|^	@|	|g' \
		-e '/^	echo/d' \
		Makefile || die

	restore_config config.def.h
	epatch_user
}

src_compile() {
	emake CC=$(tc-getCC) \
		"XFTINC=$( $(tc-getPKG_CONFIG) --cflags xft 2>/dev/null )" \
		"XFTLIBS=$( $(tc-getPKG_CONFIG) --libs xft 2>/dev/null )" \
		"XINERAMAFLAGS=$(
			usex xinerama "-DXINERAMA $(
				$(tc-getPKG_CONFIG) --cflags xinerama 2>/dev/null
			)" ''
		)" \
		"XINERAMALIBS=$(
			usex xinerama "$( $(tc-getPKG_CONFIG) --libs xinerama 2>/dev/null)" ''
		)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install

	save_config config.def.h
}
