# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/tetrix/tetrix-1.13.16.1.40c-r2.ebuild,v 1.13 2010/09/02 14:33:52 tupone Exp $

EAPI=2
inherit eutils toolchain-funcs games

MY_SV=${PV#*.*.*.}
MY_PV=${PV%.${MY_SV}}
MY_P="tetrinetx-${MY_PV}+qirc-${MY_SV}"

DESCRIPTION="A GNU TetriNET server"
HOMEPAGE="http://tetrinetx.sourceforge.net/"
SRC_URI="mirror://sourceforge/tetrinetx/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 hppa x86"
IUSE=""

DEPEND="net-libs/adns"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	sed -i \
		-e "s:GENTOO_CONFDIR:${GAMES_SYSCONFDIR}/${PN}:" \
		-e "s:GENTOO_STATEDIR:${GAMES_STATEDIR}/${PN}:" \
		-e "s:GENTOO_LOGDIR:${GAMES_LOGDIR}:" \
		src/config.h bin/game.conf \
		|| die "sed failed"
}

src_compile() {
	cd src
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} main.c -o tetrix -ladns || die "compile failed"
}

src_install() {
	dodoc AUTHORS ChangeLog README README.qirc.spectators

	dogamesbin src/tetrix
	insinto "${GAMES_SYSCONFDIR}"/${PN}
	doins bin/*

	newinitd "${FILESDIR}"/tetrix.rc tetrix

	keepdir "${GAMES_STATEDIR}"/${PN}
	dodir "${GAMES_LOGDIR}"
	touch "${D}/${GAMES_LOGDIR}"/${PN}.log

	prepgamesdirs
	fowners ${GAMES_USER_DED}:${GAMES_GROUP} "${GAMES_STATEDIR}"/${PN}
	fowners ${GAMES_USER_DED}:${GAMES_GROUP} "${GAMES_LOGDIR}"/${PN}.log
}
