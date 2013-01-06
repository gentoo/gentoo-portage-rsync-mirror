# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysolfc/pysolfc-2.0.ebuild,v 1.7 2011/04/06 20:01:31 arfrever Exp $

EAPI=3

PYTHON_USE_WITH="tk"
PYTHON_DEPEND="2:2.6"

inherit distutils eutils games

MY_PN=PySolFC
SOL_URI="mirror://sourceforge/${PN}"

DESCRIPTION="An exciting collection of more than 1000 solitaire card games"
HOMEPAGE="http://pysolfc.sourceforge.net/"
SRC_URI="${SOL_URI}/${MY_PN}-${PV}.tar.bz2
	extra-cardsets? ( ${SOL_URI}/${MY_PN}-Cardsets-${PV}.tar.bz2 )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="extra-cardsets minimal +sound"

S=${WORKDIR}/${MY_PN}-${PV}

RDEPEND="sound? ( dev-python/pygame )
	!minimal? ( dev-python/imaging[tk]
		dev-tcltk/tktable )"

PYTHON_MODNAME="pysollib"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	games_pkg_setup
}

src_prepare() {
	distutils_src_prepare

	sed -i \
		-e "/pysol.desktop/d" \
		-e "s:share/icons:share/pixmaps:" \
		-e "s:data_dir =.*:data_dir = \'share/games/${PN}\':" \
		setup.py || die
}

# Avoid running emake on shipped Makefile
src_compile() { :; }

src_install() {
	distutils_src_install

	mv -vf "${D}"/usr/bin/pysol.py "${D}${GAMES_DATADIR}"/${PN} || die
	games_make_wrapper ${PN} ./pysol.py "${GAMES_DATADIR}"/${PN}

	make_desktop_entry ${PN} "PySol Fan Club Edition" pysol01

	if use extra-cardsets; then
		insinto "${GAMES_DATADIR}"/${PN}
		doins -r "${WORKDIR}"/${MY_PN}-Cardsets-${PV}/* || die
	fi

	doman docs/*.6
	dohtml docs/*.html

	dodoc AUTHORS README

	docinto docs
	dodoc docs/README*

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	distutils_pkg_postinst
}
