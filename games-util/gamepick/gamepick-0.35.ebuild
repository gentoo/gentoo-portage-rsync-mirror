# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/gamepick/gamepick-0.35.ebuild,v 1.9 2012/05/03 03:41:15 jdhore Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Launch opengl games with custom graphic settings"
HOMEPAGE="http://www.rillion.net/gamepick/index.html"
SRC_URI="http://www.rillion.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e "s:/etc:${GAMES_SYSCONFDIR}:" \
		src/gamepick.h \
		|| die "sed failed"

	sed -i \
		-e 's/-O2//' \
		src/Makefile.in \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodir "${GAMES_SYSCONFDIR}"
	touch "${D}/${GAMES_SYSCONFDIR}"/${PN}.conf

	newicon gamepick-48x48.xpm ${PN}.xpm
	make_desktop_entry ${PN} ${PN}

	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
