# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/wmpuzzle/wmpuzzle-0.5.0.ebuild,v 1.5 2011/05/25 17:01:30 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="wmpuzzle provides a 4x4 puzzle on a 64x64 mini window"
HOMEPAGE="http://freshmeat.net/projects/wmpuzzle"
SRC_URI="http://people.debian.org/~godisch/wmpuzzle/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/libXpm
	x11-libs/libXext
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed."

	dodoc ../{CHANGES,README}
	newicon linux.xpm ${PN}.xpm
	doman ${PN}.6
	make_desktop_entry ${PN} ${PN} ${PN}

	prepgamesdirs
}
