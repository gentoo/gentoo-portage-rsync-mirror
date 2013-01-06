# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mudix/mudix-4.3-r1.ebuild,v 1.6 2011/01/12 22:55:17 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A small, stable MUD client for the console"
HOMEPAGE="http://dw.nl.eu.org/mudix.html"
SRC_URI="http://dw.nl.eu.org/mudix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""

PATCHES=( "${FILESDIR}"/${P}-as-needed.patch )

src_compile() {
	emake -C src O_FLAGS="${CFLAGS}" || die
}

src_install () {
	dogamesbin mudix || die
	dodoc README sample.usr
	prepgamesdirs
}
