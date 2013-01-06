# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/jools/jools-0.20-r1.ebuild,v 1.11 2012/04/13 19:20:20 ulm Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit eutils python games

MUS_P=${PN}-musicpack-1.0
DESCRIPTION="clone of Bejeweled, a popular pattern-matching game"
HOMEPAGE="http://pessimization.com/software/jools/"
SRC_URI="http://pessimization.com/software/jools/${P}.tar.gz
	 http://pessimization.com/software/jools/${MUS_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-python/pygame"
DEPEND=""

S=${WORKDIR}/${P}/jools

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	games_pkg_setup
}

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"/music
	unpack ${MUS_P}.tar.gz
}

src_prepare() {
	echo "MEDIAROOT = \"${GAMES_DATADIR}/${PN}\"" > config.py
	python_convert_shebangs -r 2 .
}

src_install() {
	games_make_wrapper ${PN} "$(PYTHON) ./__init__.py" "$(games_get_libdir)"/${PN}
	insinto "$(games_get_libdir)"/${PN}
	doins *.py || die "doins py failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r fonts images music sounds || die "doins data failed"
	newicon images/ruby/0001.png ${PN}.png
	make_desktop_entry ${PN} Jools
	dodoc ../{ChangeLog,doc/{POINTS,TODO}}
	dohtml ../doc/manual.html
	prepgamesdirs
}

pkg_postinst() {
	python_mod_optimize "$(games_get_libdir)"/${PN}
	games_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup "$(games_get_libdir)"/${PN}
}
