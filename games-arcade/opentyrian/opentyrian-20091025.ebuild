# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/opentyrian/opentyrian-20091025.ebuild,v 1.2 2010/03/06 12:32:16 djc Exp $

inherit eutils games

DESCRIPTION="Open-source port of the DOS game Tyrian, vertical scrolling shooter"
HOMEPAGE="http://code.google.com/p/opentyrian/"
SRC_URI="http://darklomax.org/tyrian/tyrian21.zip
	 mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-net"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-vcs/mercurial"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-datapath.diff"
	epatch "${FILESDIR}/${PV}-cflag-idiocy.diff"
}

src_compile() {
	emake DATA_PATH="${GAMES_DATADIR}/${PN}" || die "Compilation failed"
}

src_install() {
	dogamesbin tyrian || die "Failed to install game binary"
	dodoc CREDITS NEWS README || die "Failed to install documentation"
	domenu opentyrian.desktop || die "Failed to install desktop file"
	doicon tyrian.xpm || die "Failed to install program icon"
	insinto "${GAMES_DATADIR}/${PN}"
	cd "${WORKDIR}/tyrian21"
	doins * || die "Failed to install game data"
	prepgamesdirs
}
