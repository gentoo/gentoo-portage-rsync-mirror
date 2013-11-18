# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/opengfx/opengfx-0.4.7.ebuild,v 1.2 2013/11/18 10:38:04 chainsaw Exp $

EAPI=5
inherit eutils games

DESCRIPTION="OpenGFX data files for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/opengfx/"
SRC_URI="http://bundles.openttdcoop.org/opengfx/releases/${PV}/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~x86"
IUSE=""
RESTRICT="test" # nml version affects the checksums that the test uses (bug #451444)

DEPEND=">=games-util/nml-0.2.4"
RDEPEND=""

S=${WORKDIR}/${P}-source

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc48.patch
}

src_compile() {
	# ensure that we will not use gimp to regenerate the pngs
	# causes sandbox violations and not worth the effort anyway
	GIMP='' emake bundle
}

src_install() {
	insinto "${GAMES_DATADIR}/openttd/data/"
	doins *.grf opengfx.obg
	dodoc docs/{changelog.txt,readme.txt}
	prepgamesdirs
}
