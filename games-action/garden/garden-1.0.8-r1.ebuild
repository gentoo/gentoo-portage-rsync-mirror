# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/garden/garden-1.0.8-r1.ebuild,v 1.1 2013/06/30 07:05:30 slyfox Exp $

EAPI=5
inherit eutils autotools games

DESCRIPTION="Multiplatform vertical shoot-em-up with non-traditional elements"
HOMEPAGE="http://garden.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="<media-libs/allegro-5"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-underlink.patch
	epatch "${FILESDIR}"/${P}-drop-AS_INIT.patch #475248
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	doicon resources/garden.svg
	make_desktop_entry garden "Garden of coloured lights"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
