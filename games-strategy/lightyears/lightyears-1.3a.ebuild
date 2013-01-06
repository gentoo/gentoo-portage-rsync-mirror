# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/lightyears/lightyears-1.3a.ebuild,v 1.7 2011/04/25 20:36:38 arfrever Exp $

EAPI=3
PYTHON_DEPEND="2"
inherit eutils python games

DESCRIPTION="a single-player game with a science-fiction theme"
HOMEPAGE="http://www.jwhitham.org.uk/20kly/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/pygame"

src_prepare() {
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i \
		-e "s:@GENTOO_LIBDIR@:$(games_get_libdir)/${PN}:" \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		${PN} || die "Changing library path failed"
	python_convert_shebangs -r 2 .
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	insinto "$(games_get_libdir)/${PN}"
	doins code/*.py || die "doins code failed"

	dodoc README.txt

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r audio data manual || die "doins data failed"

	newicon data/32.png ${PN}.png
	make_desktop_entry ${PN} "Light Years Into Space"
	prepgamesdirs
}

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

pkg_postinst() {
	python_mod_optimize "$(games_get_libdir)/${PN}"
	games_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup "$(games_get_libdir)/${PN}"
}
