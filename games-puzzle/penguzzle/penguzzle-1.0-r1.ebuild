# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/penguzzle/penguzzle-1.0-r1.ebuild,v 1.2 2007/04/23 11:46:53 nyhm Exp $

inherit eutils games

DESCRIPTION="Tcl/Tk variant of the well-known 15-puzzle game"
HOMEPAGE="http://www.naskita.com/linux/penguzzle/penguzzle.shtml"
SRC_URI="http://www.naskita.com/linux/${PN}/${PN}.zip"

LICENSE="penguzzle"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-lang/tk
	dev-tcltk/tclx"
DEPEND="app-arch/unzip"

S=${WORKDIR}/${PN}${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:~/puzz/images:${GAMES_DATADIR}/${PN}:" \
		lib/init \
		|| die "sed init failed"
	sed -i \
		-e "s:~/puzz/lib:$(games_get_libdir)/${PN}:" \
		bin/${PN} \
		|| die "sed ${PN} failed"

	epatch "${FILESDIR}"/${P}-tclx.patch
}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins images/img0.gif || die "doins img0.gif failed"

	insinto "$(games_get_libdir)"/${PN}
	doins lib/init || die "doins init failed"

	dogamesbin bin/${PN} || die "dogamesbin failed"

	dodoc README
	prepgamesdirs
}
