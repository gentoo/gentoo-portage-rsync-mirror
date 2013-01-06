# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/accelerator3d/accelerator3d-0.1.1-r1.ebuild,v 1.4 2012/02/26 14:55:15 tupone Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit eutils python games

DESCRIPTION="Fast-paced, 3D, first-person shoot/dodge-'em-up, in the vain of Tempest or n2o"
HOMEPAGE="http://accelerator3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/accelerator3d/accelerator-${PV}.tar.bz2"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-python/pyode
	dev-python/pygame
	dev-python/pyopengl"

S=${WORKDIR}/${PN}

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gentoo-paths.patch \
		"${FILESDIR}"/${P}-gllightmodel.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		accelerator.py || die
	python_convert_shebangs 2 accelerator.py
}

src_install() {
	newgamesbin accelerator.py accelerator || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins gfx/* snd/* || die "doins failed"
	dodoc CHANGELOG README
	make_desktop_entry accelerator

	prepgamesdirs
}
