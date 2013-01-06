# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tf/tf-40-r2.ebuild,v 1.11 2008/07/18 16:15:32 mr_bones_ Exp $

inherit eutils

MY_P=${P}s1
DESCRIPTION="A small, flexible, screen-oriented MUD client (aka TinyFugue)"
HOMEPAGE="http://tf.tcp.com/~hawkeye/tf/"
SRC_URI="mirror://tinyfugue/${MY_P}.tar.gz
	doc? ( mirror://tinyfugue/${MY_P}-help.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=" ~amd64 ~sparc x86"
IUSE="doc"

DEPEND=">=sys-libs/ncurses-5.2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}/${P}-gentoo.diff" \
		"${FILESDIR}/${P}-gcc4.patch"
}

src_compile() {
	echo 'y' | ./unixmake config || die
	./unixmake all || die
}

src_install() {
	dobin src/tf || die
	newman src/tf.1.catman tf.1
	exeinto /usr/lib/${MY_P}-lib
	doexe tf-lib/*
	insinto /usr/lib/${MY_P}-lib
	doins CHANGES
	dodoc CHANGES CREDITS README
	use doc && dohtml -r "${WORKDIR}"/${MY_P}-help
}
