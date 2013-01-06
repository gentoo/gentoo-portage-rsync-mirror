# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/sarien/sarien-0.7.0.ebuild,v 1.11 2008/05/15 12:38:14 nyhm Exp $

inherit games

DESCRIPTION="Sierra AGI resource interpreter engine"
HOMEPAGE="http://sarien.sourceforge.net/"
SRC_URI="mirror://sourceforge/sarien/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:/etc:${GAMES_SYSCONFDIR}:" src/filesys/unix/path.c \
			|| die "sed src/filesys/unix/path.c failed"
}

src_compile() {
	egamesconf || die
	# buggy build - comments on bug #45813
	emake -j1 || die "emake failed"
}

src_install() {
	dogamesbin bin/sarien || die "dogamesbin failed"
	insinto "${GAMES_SYSCONFDIR}"
	doins etc/sarien.cfg || die "doins failed"
	dodoc doc/{AUTHORS,BUGS,Changelog,README*,TODO,roadmap.txt}
	prepgamesdirs
}
