# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/opensfx/opensfx-0.2.3.ebuild,v 1.8 2013/02/07 22:08:50 ulm Exp $

EAPI=2
inherit games

DESCRIPTION="OpenSFX data files for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/opensfx/"
SRC_URI="http://bundles.openttdcoop.org/${PN}/releases/${P}-source.tar.gz"

LICENSE="CC-Sampling-Plus-1.0"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE=""

DEPEND="games-util/catcodec"
RDEPEND=""

S=${WORKDIR}/${P}-source

src_install() {
	insinto "${GAMES_DATADIR}"/openttd/data/
	doins opensfx.cat opensfx.obs || die
	dodoc docs/{changelog.txt,readme.ptxt} || die
	prepgamesdirs
}
