# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/outerspace/outerspace-0.5.67-r1.ebuild,v 1.3 2011/01/30 18:14:46 phajdan.jr Exp $

EAPI=2
PYTHON_DEPEND="2"

inherit eutils python games

MY_PN=${PN/outerspace/Outer Space}
DESCRIPTION="on-line strategy game taking place in the dangerous universe"
HOMEPAGE="http://www.ospace.net/"
SRC_URI="mirror://sourceforge/ospace/Client/${PV}/Outer%20Space-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-python/pygame-1.7"

S=${WORKDIR}/${MY_PN}-${PV}

src_prepare() {
	sed -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		-e "s:@GENTOO_LIBDIR@:$(games_get_libdir)/${PN}:" \
		-e "s:python:$(PYTHON -a):" \
		"${FILESDIR}"/${PN} > ${PN} \
		|| die "sed failed"
}

src_install() {
	insinto "$(games_get_libdir)"/${PN}
	doins -r osc.py lib libsrvr || die "doins lib failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r res || die "doins data failed"
	dogamesbin ${PN} || die "dogamesbin failed"
	newicon res/icon48.png ${PN}.png
	make_desktop_entry ${PN} "${MY_PN}"
	prepgamesdirs
}

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}
