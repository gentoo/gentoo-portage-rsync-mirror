# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gtkatlantic/gtkatlantic-0.4.2.ebuild,v 1.5 2012/05/04 04:30:10 jdhore Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Monopoly-like game that works with the monopd server"
HOMEPAGE="http://gtkatlantic.gradator.net/"
SRC_URI="http://gtkatlantic.gradator.net/downloads/v0.4/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/libxml2
	media-libs/libpng"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng14.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
