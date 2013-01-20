# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/wmpuzzle/wmpuzzle-0.5.1.ebuild,v 1.1 2013/01/20 12:24:26 ssuominen Exp $

EAPI=5
inherit eutils games

DESCRIPTION="wmpuzzle provides a 4x4 puzzle on a 64x64 mini window"
HOMEPAGE="http://freshmeat.net/projects/wmpuzzle"
SRC_URI="http://people.debian.org/~godisch/wmpuzzle/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

S=${WORKDIR}/${P}/src

src_install() {
	dogamesbin ${PN}

	dodoc ../{CHANGES,README}
	newicon numbers.xpm ${PN}.xpm
	doman ${PN}.6
	make_desktop_entry ${PN}

	prepgamesdirs
}
