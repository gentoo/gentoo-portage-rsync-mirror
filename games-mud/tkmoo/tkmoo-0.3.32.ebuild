# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/tkmoo/tkmoo-0.3.32.ebuild,v 1.13 2007/04/09 18:43:53 nyhm Exp $

inherit eutils games

MY_PN=${PN/moo/MOO-light}
MY_P=${P/moo/MOO-light}
DESCRIPTION="MOO Client written in Tcl/Tk"
HOMEPAGE="http://www.awns.com/tkMOO-light/"
SRC_URI="http://www.awns.com/tkMOO-light/Source/${MY_P}.tar.gz"

LICENSE="tkMOO"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"
IUSE=""

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-Makefile-noclean.patch"
	epatch "${FILESDIR}/${PV}-keys-workaround.patch"
}

src_compile() {
	emake \
		WISH="$(type -P wish)" \
		TKMOO_LIB_DIR="$(games_get_libdir)/${MY_PN}" \
		TKMOO_BIN_DIR="${GAMES_BINDIR}" \
		|| die "emake failed"
}

src_install() {
	emake \
		TKMOO_LIB_DIR="${D}/$(games_get_libdir)/${MY_PN}" \
		TKMOO_BIN_DIR="${D}/${GAMES_BINDIR}" \
		install \
		|| die "emake install failed"
	dodoc README dot.tkmoolightrc bugsmail.txt
	dosym tkMOO-lite "${GAMES_BINDIR}/tkmoo"
	prepgamesdirs
}
