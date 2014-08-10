# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/watermelons/watermelons-1.1.1.ebuild,v 1.7 2014/08/10 21:23:05 slyfox Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit eutils python games

MY_PN="melons"
DESCRIPTION="A thrilling watermelon bouncing game"
HOMEPAGE="http://www.imitationpickles.org/melons/index.html"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}.tgz"
# No version upstream
#SRC_URI="http://www.imitationpickles.org/${MY_PN}/${MY_PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-python/pygame"

S=${WORKDIR}/${MY_PN}

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	sed -i \
		-e "s:melons.hs:${GAMES_STATEDIR}/${PN}/&:" \
		main.py \
		|| die "sed failed"

	cat <<-EOF > "${PN}"
	#!/bin/bash
	cd "${GAMES_DATADIR}/${PN}"
	exec $(PYTHON) main.py
EOF
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data pgu const.py game.py main.py melon.py melons.py menu.py trampoline.py \
		|| die "doins failed"
	dodoc *.txt
	dodir "${GAMES_STATEDIR}/${PN}"
	touch "${D}${GAMES_STATEDIR}"/${PN}/melons.hs
	fperms 664 "${GAMES_STATEDIR}"/${PN}/melons.hs
	newicon data/mellon0013.png "${PN}.png" || die "newicon failed"
	make_desktop_entry ${PN} Watermelons
	prepgamesdirs
}
