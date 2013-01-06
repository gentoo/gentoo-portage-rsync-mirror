# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/megaglest-data/megaglest-data-3.7.1-r1.ebuild,v 1.3 2012/12/28 11:28:27 ago Exp $

EAPI=4
inherit cmake-utils eutils games

MY_PN="megaglest"
DESCRIPTION="Data files for the cross-platform 3D realtime strategy game MegaGlest"
HOMEPAGE="http://www.megaglest.org/"
SRC_URI="mirror://sourceforge/${MY_PN}/${P}.tar.xz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="~games-strategy/megaglest-${PV}"

DOCS=( docs/AUTHORS.data.txt docs/CHANGELOG.txt docs/README.txt )

S=${WORKDIR}/${MY_PN}-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-dutch.patch
}

src_configure() {
	local mycmakeargs=(
		-DMEGAGLEST_BIN_INSTALL_PATH="${GAMES_BINDIR}"
		-DMEGAGLEST_DATA_INSTALL_PATH="${GAMES_DATADIR}/${MY_PN}"
		-DMEGAGLEST_ICON_INSTALL_PATH="/usr/share/pixmaps"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	use doc && HTML_DOCS="docs/glest_factions/"

	cmake-utils_src_install

	prepgamesdirs

}
