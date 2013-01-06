# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bitefusion/bitefusion-1.0.1.ebuild,v 1.6 2011/06/20 19:15:46 tupone Exp $

EAPI=2
inherit eutils autotools games

DESCRIPTION="A snake game with 15 levels"
HOMEPAGE="http://www.junoplay.com"
SRC_URI="http://www.junoplay.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl"

# just to avoid QA notice
PATCHES=( "${FILESDIR}"/${P}-gentoo.patch
	"${FILESDIR}"/${P}-underlink.patch )

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	dodoc AUTHORS
	make_desktop_entry bitefusion "Bitefusion"
	prepgamesdirs
}
