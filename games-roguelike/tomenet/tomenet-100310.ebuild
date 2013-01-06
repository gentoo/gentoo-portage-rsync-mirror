# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/tomenet/tomenet-100310.ebuild,v 1.2 2010/04/26 14:52:24 phajdan.jr Exp $

EAPI=2
inherit games

DESCRIPTION="A MMORPG based on the works of J.R.R. Tolkien"
HOMEPAGE="http://www.tomenet.net/"
SRC_URI="http://angband.oook.cz/${PN}-nightly/${PN}-cvs-snapshot-${PV}.tar.bz2"

LICENSE="Moria"
SLOT="0"
KEYWORDS="x86"
IUSE="X Xaw3d"

DEPEND="sys-libs/ncurses
	X? ( x11-libs/libX11 )
	Xaw3d? ( x11-libs/libXaw )"

S=${WORKDIR}/${PN}/src

src_prepare() {
	sed -i \
		-e '/^CC =/d' \
		makefile \
		|| die "sed failed"
}

src_compile() {
	local GENTOO_DEFINES="-DUSE_GCU "
	local GENTOO_LIBS="-lncurses -lcrypt -lm"

	if use Xaw3d; then
		GENTOO_DEFINES="${GENTOO_DEFINES} -DUSE_XAW"
	elif use X; then
		GENTOO_DEFINES="${GENTOO_DEFINES} -DUSE_X11"
	fi
	if use X; then
		GENTOO_LIBS="${GENTOO_LIBS} -lX11"
	fi
	if use Xaw3d; then
		GENTOO_LIBS="${GENTOO_LIBS} -lXaw"
	fi
	emake CFLAGS="${CFLAGS} ${GENTOO_DEFINES} -Iserver -Iserver/lua" \
		LIBS="${GENTOO_LIBS}" tomenet \
		|| die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	dodoc ../{ChangeLog,TomeNET-Guide.txt,changes.txt}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To start playing right away:"
	elog "$ tomenet totem.ielf.org"
}
