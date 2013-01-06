# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/gtklife/gtklife-5.1.ebuild,v 1.7 2012/05/03 03:29:41 jdhore Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A Conway's Life simulator for Unix"
HOMEPAGE="http://ironphoenix.org/tril/gtklife/"
SRC_URI="http://ironphoenix.org/tril/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	egamesconf \
		--with-gtk2 \
		--with-docdir=/usr/share/doc/${PF}/html
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r graphics patterns || die "doins failed"

	newicon icon_48x48.png ${PN}.png
	make_desktop_entry ${PN} GtkLife

	dohtml doc/*
	dodoc AUTHORS README NEWS
	prepgamesdirs
}
