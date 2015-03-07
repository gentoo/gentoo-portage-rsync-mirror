# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/planets/planets-0.1.13.ebuild,v 1.8 2015/03/07 21:45:58 tupone Exp $

EAPI=5
inherit eutils games

DESCRIPTION="a simple interactive planetary system simulator"
HOMEPAGE="http://planets.homedns.org/"
SRC_URI="http://planets.homedns.org/dist/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="dev-lang/tcl
	dev-lang/tk"
DEPEND="${RDEPEND}
	dev-lang/ocaml[tk]"

src_install() {
	dogamesbin planets
	doicon ${PN}.png
	domenu ${PN}.desktop
	doman ${PN}.1
	dohtml getting_started.html
	dodoc CHANGES CREDITS KEYBINDINGS.txt README TODO
	prepgamesdirs
}
