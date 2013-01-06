# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/hugo/hugo-2.12.ebuild,v 1.5 2011/02/22 19:12:43 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="PC-Engine (Turbografx16) emulator for linux"
HOMEPAGE="http://www.zeograd.com/"
SRC_URI="http://www.zeograd.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="x11-libs/gtk+:2
	media-libs/libsdl[video]
	media-libs/libvorbis"

PATCHES=( "${FILESDIR}/${P}"-gcc41.patch )

src_install() {
	dogamesbin hugo || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r pixmaps || die "doins gamedata failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
	dohtml doc/*html
	prepgamesdirs
}
