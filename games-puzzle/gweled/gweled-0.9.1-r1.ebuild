# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gweled/gweled-0.9.1-r1.ebuild,v 1.3 2015/02/10 10:15:30 ago Exp $

EAPI=2
inherit flag-o-matic autotools games

DESCRIPTION="Bejeweled clone game"
HOMEPAGE="http://www.gweled.org/"
SRC_URI="http://launchpad.net/gweled/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	media-libs/libmikmod
	gnome-base/librsvg:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	eautoreconf
}

src_configure() {
	filter-flags -fomit-frame-pointer
	append-ldflags -Wl,--export-dynamic
	egamesconf \
		--disable-dependency-tracking \
		--disable-setgid
}

src_install() {
	emake DESTDIR="${D}" install || die
	# FIXME: /var/lib is hard-coded.  Need to patch this.
	touch "${D}/var/games/gweled/gweled.timed.scores"
	fperms 664 /var/lib/games/gweled.timed.scores
	gamesowners -R "${D}/var/games/gweled"
	dodoc AUTHORS NEWS
	prepgamesdirs
}
