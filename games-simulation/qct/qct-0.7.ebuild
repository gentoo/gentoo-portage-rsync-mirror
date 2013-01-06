# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/qct/qct-0.7.ebuild,v 1.10 2010/10/18 19:17:41 mr_bones_ Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit eutils python games

DESCRIPTION="Quiet Console Town puts you in the place of the mayor of a budding new console RPG city"
HOMEPAGE="http://llynmir.net/qct"
SRC_URI="http://www.sourcefiles.org/Games/Role_Play/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-python/pygame-1.5.5"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-constant.patch
	python_convert_shebangs -r 2 .
}

src_install() {
	local destdir="${GAMES_DATADIR}/${PN}"
	insinto "${destdir}"
	exeinto "${destdir}"

	dodoc README
	doins *.py *.png
	doexe qct.py

	games_make_wrapper qct "./qct.py" "${destdir}"

	prepgamesdirs
}

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}
