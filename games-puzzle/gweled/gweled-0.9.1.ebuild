# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gweled/gweled-0.9.1.ebuild,v 1.5 2012/12/04 11:16:46 ago Exp $

EAPI=2
inherit flag-o-matic games

DESCRIPTION="Bejeweled clone game"
HOMEPAGE="http://www.gweled.org/"
SRC_URI="http://launchpad.net/gweled/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	media-libs/libmikmod
	gnome-base/librsvg:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	filter-flags -fomit-frame-pointer
	append-ldflags -Wl,--export-dynamic
	econf \
		--disable-dependency-tracking \
		--disable-setgid
}

src_install() {
	emake DESTDIR="${D}" install || die
	# FIXME: /var/lib is hard-coded.  Need to patch this.
	touch "${D}/var/lib/games/gweled.timed.scores"
	fperms 664 /var/lib/games/gweled.timed.scores
	gamesowners -R "${D}/var/lib/games/"
	dodoc AUTHORS NEWS
	prepgamesdirs
}
