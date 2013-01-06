# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/openmsx/openmsx-0.3.1.ebuild,v 1.5 2010/10/15 13:53:56 maekke Exp $

EAPI=2
PYTHON_DEPEND="2:2.6"
inherit python games

DESCRIPTION="An ambiguously named music replacement set for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/openmsx/"
SRC_URI="http://bundles.openttdcoop.org/openmsx/releases/${PV}/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86"
IUSE=""

S=${WORKDIR}/${P}-source

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_compile() {
	emake bundle || die
}

src_install() {
	insinto "${GAMES_DATADIR}"/openttd/gm/${P}
	doins ${P}/{*.mid,openmsx.obm} || die
	dodoc ${P}/{changelog.txt,readme.txt} || die
	prepgamesdirs
}
