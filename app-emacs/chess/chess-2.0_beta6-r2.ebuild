# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/chess/chess-2.0_beta6-r2.ebuild,v 1.3 2009/10/15 14:07:10 maekke Exp $

inherit elisp

DESCRIPTION="A chess client and library for Emacs"
HOMEPAGE="http://emacs-chess.sourceforge.net/"
SRC_URI="mirror://sourceforge/emacs-chess/${P/_beta/b}.tar.gz
	mirror://gentoo/emacs-chess-sounds-${PV%%_*}.tar.bz2
	mirror://gentoo/emacs-chess-pieces-${PV%%_*}.tar.bz2"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( games-board/gnuchess
		games-board/crafty
		games-board/phalanx
		games-board/sjeng )"

S="${WORKDIR}/${PN}"
DOCS="ChangeLog EPD.txt PGN.txt PLAN README TODO"
ELISP_PATCHES="${PV}-chess-pos-move-gentoo.patch
	${PV}-chess-common-handler-gentoo.patch"
SITEFILE="50${PN}-gentoo.el"

# this is needed; elisp.eclass redefines src_compile() from portage default
src_compile() {
	emake || die "emake failed"
}

src_install() {
	elisp_src_install
	doinfo chess.info || die "doinfo failed"
	insinto "${SITEETC}/${PN}"
	doins -r "${WORKDIR}"/{sounds,pieces} || die "doins failed"
}
