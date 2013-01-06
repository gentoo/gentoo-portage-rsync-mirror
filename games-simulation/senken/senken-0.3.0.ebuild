# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/senken/senken-0.3.0.ebuild,v 1.10 2011/03/01 07:20:13 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="city simulation game"
HOMEPAGE="http://www.contrib.andrew.cmu.edu/~tmartin/senken/"
SRC_URI="http://www.contrib.andrew.cmu.edu/~tmartin/senken/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2
	>=media-libs/libsdl-1.2.4
	media-libs/sdl-image
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i \
		-e "s:/usr/local/share:${GAMES_DATADIR}:" \
		lib/utils.h \
		|| die "sed lib/utils.h failed"
	epatch "${FILESDIR}"/${P}-as-needed.patch
}
src_configure() {
	egamesconf $(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO

	dodir "${GAMES_DATADIR}"
	mv "${D}/${GAMES_PREFIX}/share/senken" "${D}/${GAMES_DATADIR}/" \
		|| die "mv failed"
	rm -rf "${D}/${GAMES_PREFIX}"/{include,lib,man,share}

	insinto "${GAMES_DATADIR}/senken/img"
	doins img/*.png

	find "${D}/${GAMES_DATADIR}/" -type f -exec chmod a-x \{\} \;
	find "${D}/${GAMES_DATADIR}/" -name "Makefile.*" -exec rm -f \{\} \;

	prepgamesdirs
}
