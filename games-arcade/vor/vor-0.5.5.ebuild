# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/vor/vor-0.5.5.ebuild,v 1.1 2013/01/18 09:03:56 mr_bones_ Exp $

EAPI=5
inherit eutils games

DESCRIPTION="Variations on Rockdodger: Dodge the rocks until you die"
HOMEPAGE="http://jasonwoof.org/vor"
SRC_URI="http://qualdan.com/vor/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl[audio,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[mod]"
RDEPEND="${DEPEND}"

src_install() {
	dodir "${GAMES_BINDIR}"
	DOCS="README* todo" default
	newicon data/icon.png ${PN}.png
	make_desktop_entry ${PN} VoR
	prepgamesdirs
}
