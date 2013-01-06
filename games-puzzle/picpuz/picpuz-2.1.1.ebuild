# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/picpuz/picpuz-2.1.1.ebuild,v 1.4 2012/05/04 04:45:27 jdhore Exp $

EAPI=2
inherit eutils games

DESCRIPTION="a jigsaw puzzle program"
HOMEPAGE="http://kornelix.squarespace.com/picpuz/"
SRC_URI="http://kornelix.squarespace.com/storage/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${P}-build.patch )

src_compile() {
	emake \
		BINDIR="${GAMES_BINDIR}" \
		DATADIR="${GAMES_DATADIR}"/${PN} \
		DOCDIR=/usr/share/doc/${PF}/html \
		|| die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r icons locales || die "doins failed"
	doicon icons/${PN}.png
	make_desktop_entry ${PN} Picpuz
	dohtml -r doc/{userguide-en.html,images}
	dodoc doc/{CHANGES,README,TRANSLATIONS}
	prepgamesdirs
}
