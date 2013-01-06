# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/opengfx/opengfx-0.4.4.ebuild,v 1.9 2012/12/31 16:32:47 ago Exp $

EAPI=3
inherit games

DESCRIPTION="OpenGFX data files for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/opengfx/"
SRC_URI="http://bundles.openttdcoop.org/opengfx/releases/${PV}/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE=""

DEPEND=">=games-util/nml-0.2.3"
RDEPEND=""

S=${WORKDIR}/${P}-source

src_prepare() {
	sed -i -e 's/\[a-z\]/[[:alpha:]]/' ./scripts/Makefile.in || die

	# ensure that we will not use gimp to regenerate the pngs
	# causes sandbox violations and not worth the effort anyway
	sed -i \
		-e 's:echo "gimp":echo "":g' \
		scripts/Makefile.def || die
}

src_compile() {
	emake bundle || die
}

src_install() {
	insinto "${GAMES_DATADIR}/openttd/data/"
	doins *.grf opengfx.obg || die
	dodoc docs/{changelog.txt,readme.txt}
	prepgamesdirs
}
