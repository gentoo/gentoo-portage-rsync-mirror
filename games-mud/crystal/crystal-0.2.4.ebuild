# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/crystal/crystal-0.2.4.ebuild,v 1.4 2012/03/06 20:37:57 ranger Exp $

EAPI=2
inherit eutils games

DESCRIPTION="The crystal MUD client"
HOMEPAGE="http://www.evilmagic.org/crystal/"
SRC_URI="http://www.evilmagic.org/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="sys-libs/zlib
	sys-libs/ncurses
	dev-libs/openssl
	virtual/libiconv"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
	# avoid colliding with xscreensaver (bug #281191)
	sed -i \
		-e '/^man_MANS/s/crystal/crystal-mud/' \
		Makefile.in \
		|| die "sed failed"
	mv crystal.6 crystal-mud.6
}

src_configure() {
	egamesconf \
		--disable-scripting || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
