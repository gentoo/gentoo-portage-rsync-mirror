# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/uglygs/uglygs-0_rc11.ebuild,v 1.13 2014/07/15 14:55:11 jer Exp $

EAPI=2
inherit eutils games

MY_P=${P/0_/}
DESCRIPTION="quickly searches the network for game servers"
HOMEPAGE="http://uglygs.uglypunk.com/"
SRC_URI="ftp://ftp.uglypunk.com/uglygs/current/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha hppa ppc sparc x86"
IUSE=""

RDEPEND="net-analyzer/rrdtool[graph]
	dev-lang/perl"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-uglygs.conf.patch
	sed -i \
		-e "s:GENTOO_DIR:$(games_get_libdir)/${PN}:" uglygs.conf \
		|| die "sed failed"
	epatch "${FILESDIR}"/${PV}-uglygs.pl.patch
	sed -i \
		-e "s:GENTOO_DIR:${GAMES_SYSCONFDIR}:" uglygs.pl \
		|| die "sed failed"
	sed -i \
		-e "s/strndup/${PN}_strndup/" qstat/qstat.c \
		|| die "sed failed"
}

src_compile() {
	emake -C qstat CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	insinto "${GAMES_SYSCONFDIR}"
	doins uglygs.conf qstat/qstat.cfg || die "doins failed"

	dogamesbin uglygs.pl || die "dogamesbin failed"

	insinto "$(games_get_libdir)"/${PN}
	doins -r data templates tmp || die "doins failed"
	insinto "$(games_get_libdir)"/${PN}/images
	doins -r images/{avp2,bds,default.gif,hls,j2s,mhs,q3s,rws,sf2s,uns,vcs} \
		|| die "doins failed"
	dosym bds "$(games_get_libdir)"/${PN}/images/bdl
	keepdir "$(games_get_libdir)"/${PN}/tmp

	exeinto "$(games_get_libdir)"/${PN}
	doexe qstat/qstat || die "doexe failed"

	dodoc CHANGES README

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "Dont forget to setup ${GAMES_SYSCONFDIR}/uglygs.conf and ${GAMES_SYSCONFDIR}/qstat.cfg"
}
