# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gweled/gweled-0.7.ebuild,v 1.8 2012/05/04 04:45:28 jdhore Exp $

EAPI=2
inherit flag-o-matic games

DESCRIPTION="Bejeweled clone game"
HOMEPAGE="http://sebdelestaing.free.fr/gweled/"
SRC_URI="http://sebdelestaing.free.fr/gweled/Release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	media-libs/libmikmod
	gnome-base/librsvg:2
	>=gnome-base/libgnomeui-2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e "209d" \
		-e "368 s/swap_sfx/click_sfx/" \
		src/main.c \
		|| die "sed failed"
	sed -i \
		-e "/free (message)/ s/free/g_free/" \
		src/graphic_engine.c \
		|| die "sed failed"
}

src_configure() {
	filter-flags -fomit-frame-pointer
	append-ldflags -Wl,--export-dynamic
	econf --disable-setgid
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	# FIXME: /var/lib is hard-coded.  Need to patch this.
	touch "${D}/var/lib/games/gweled.timed.scores"
	fperms 664 /var/lib/games/gweled.timed.scores
	gamesowners -R "${D}/var/lib/games/"
	dodoc AUTHORS NEWS
	prepgamesdirs
}
