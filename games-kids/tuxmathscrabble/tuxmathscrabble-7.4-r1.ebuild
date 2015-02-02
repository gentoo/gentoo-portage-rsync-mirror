# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmathscrabble/tuxmathscrabble-7.4-r1.ebuild,v 1.2 2015/02/02 17:28:20 tupone Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1 multilib games

MY_PN=TuxMathScrabble
MY_P=${PN}-0.${PV}
DESCRIPTION="math-version of the popular board game for children 4-10"
HOMEPAGE="http://www.asymptopia.org/"
SRC_URI="mirror://gentoo/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

CDEPEND="${PYTHON_DEPS}
	dev-python/wxpython[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}
	app-arch/unzip"
RDEPEND="${CDEPEND}
	dev-python/pygame[${PYTHON_USEDEP}]"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python-single-r1_pkg_setup
	games_pkg_setup
}

src_prepare() {
	rm -f $(find . -name '*.pyc')
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${MY_PN}:" \
		${MY_PN}/tms.py \
		.tms_config_master \
		|| die "sed failed"
	python_fix_shebang .
}

src_install() {
	newgamesbin ${PN}.py ${PN}

	insinto $(python_get_sitedir)
	doins -r ${MY_PN}

	insinto "${GAMES_DATADIR}"/${MY_PN}
	doins -r .tms_config_master Font

	python_optimize

	newicon tms.ico ${PN}.ico
	make_desktop_entry ${PN} ${PN} /usr/share/pixmaps/${PN}.ico

	dodoc CHANGES README
	prepgamesdirs
}
