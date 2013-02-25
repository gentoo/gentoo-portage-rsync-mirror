# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/advancescan/advancescan-1.16.ebuild,v 1.3 2013/02/25 11:40:49 ago Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="A command line rom manager for MAME, MESS, AdvanceMAME, AdvanceMESS and Raine"
HOMEPAGE="http://advancemame.sourceforge.net/scan-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/expat
	sys-libs/zlib"

src_prepare() {
	rm -rf expat
	epatch "${FILESDIR}"/${P}-sys-expat.patch
	eautoreconf
}

src_install() {
	dogamesbin advscan advdiff || die
	dodoc AUTHORS HISTORY README doc/*.txt advscan.rc.linux
	doman doc/{advscan,advdiff}.1
	dohtml doc/*.html
	prepgamesdirs
}
