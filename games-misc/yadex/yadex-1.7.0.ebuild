# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/yadex/yadex-1.7.0.ebuild,v 1.11 2009/08/05 02:53:29 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A Doom level (wad) editor"
HOMEPAGE="http://www.teaser.fr/~amajorel/yadex/"
SRC_URI="http://www.teaser.fr/~amajorel/yadex/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
RESTRICT="test"

DEPEND="x11-libs/libX11"

src_prepare() {
	sed -i \
		-e '/iwad/s/local\///' \
		"${S}"/yadex.cfg \
		|| die "sed yadex.cfg failed"
	epatch "${FILESDIR}/${P}"-NULL-is-not-zero.patch \
		"${FILESDIR}/${P}"-elif.patch
	# Force the patched file to be old, otherwise the compile fails
	touch -t 196910101010 "${S}"/src/wadlist.cc
	touch -t 196910101010 "${S}"/src/gfx.cc
}

src_configure() {
	# not an autoconf script
	./configure --prefix="/usr" || die "configure failed"
}

src_compile() {
	emake CC="${CC}" CXX="${CXX}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin obj/0/yadex || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}/${PV}"
	doins ygd/* || die "doins failed (data)"
	doman doc/yadex.6
	dodoc CHANGES FAQ README TODO VERSION
	dohtml doc/*
	insinto /etc/yadex/${PV}
	doins yadex.cfg || die "doins failed (cfg)"
	prepgamesdirs
}
