# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/cylindrix/cylindrix-1.0.ebuild,v 1.11 2012/05/21 19:22:14 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="Action game in a tube"
HOMEPAGE="http://www.hardgeus.com/cylindrix/"
SRC_URI="http://www.hardgeus.com/cylindrix/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=media-libs/allegro-4.0.3
	<media-libs/allegro-5"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-underlink.patch
	sed -i \
		-e "/g_DataPath/s:\./:${GAMES_DATADIR}/${PN}/:" \
		sb_stub.c \
		|| die "sed failed"
	ecvs_clean
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins people.dat cylindrx.fli || die "doins failed"
	doins -r wav_data 3d_data gamedata pcx_data || die "doins failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
	fperms g+w "${GAMES_DATADIR}"/${PN}/gamedata/game.cfg
}
