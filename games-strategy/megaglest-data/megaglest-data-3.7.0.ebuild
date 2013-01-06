# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/megaglest-data/megaglest-data-3.7.0.ebuild,v 1.1 2012/11/14 17:10:49 hasufell Exp $

EAPI=4
inherit cmake-utils games

MY_PN="megaglest"
DESCRIPTION="Data files for the cross-platform 3D realtime strategy game MegaGlest"
HOMEPAGE="http://www.megaglest.org/"
SRC_URI="mirror://sourceforge/${MY_PN}/${P}.tar.xz
	mirror://sourceforge/${MY_PN}/${MY_PN}-source-embedded-${PV}.tar.xz"

LICENSE="CCPL-Attribution-ShareAlike-3.0 BitstreamVera GPL-2+ GPL-2-with-font-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="~games-strategy/megaglest-${PV}"

DOCS=( docs/AUTHORS.data.txt docs/CHANGELOG.txt docs/README.txt )

S=${WORKDIR}/${MY_PN}-${PV}

src_prepare() {
	sed -i \
		-e 's/# MEGAGLEST_FONT/MEGAGLEST_FONT/' \
		data/lang/*.lng || die "setting default font in .lng failed!"
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

	insinto "${GAMES_DATADIR}/${MY_PN}"/data/core/fonts
	doins "${WORKDIR}"/${MY_PN}-${PV}/data/core/fonts/*.ttf

	prepgamesdirs

}
