# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/opengfx/opengfx-0.4.6.1.ebuild,v 1.2 2013/05/09 18:41:08 tupone Exp $

EAPI=5
inherit eutils games

DESCRIPTION="OpenGFX data files for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/opengfx/"
SRC_URI="http://bundles.openttdcoop.org/opengfx/releases/${PV}/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""
RESTRICT="test" # nml version affects the checksums that the test uses (bug #451444)

DEPEND=">=games-util/nml-0.2.4"
RDEPEND=""

S=${WORKDIR}/${P}-source

src_prepare() {
	sed -i -e 's/\[a-z\]/[[:alpha:]]/' ./scripts/Makefile.in || die

	# ensure that we will not use gimp to regenerate the pngs
	# causes sandbox violations and not worth the effort anyway
	sed -i \
		-e 's:echo "gimp":echo "":g' \
		scripts/Makefile.def || die
	epatch "${FILESDIR}"/${P}-gcc48.patch
}

src_compile() {
	emake bundle
}

src_install() {
	insinto "${GAMES_DATADIR}/openttd/data/"
	doins *.grf opengfx.obg
	dodoc docs/{changelog.txt,readme.txt}
	prepgamesdirs
}
