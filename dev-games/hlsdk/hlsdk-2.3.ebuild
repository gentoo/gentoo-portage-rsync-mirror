# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/hlsdk/hlsdk-2.3.ebuild,v 1.7 2007/04/04 19:21:40 nyhm Exp $

inherit games

DESCRIPTION="Half-Life Software Development Kit for mod authors"
HOMEPAGE="http://www.valvesoftware.com/hlsdk.htm"
SRC_URI="http://www.metamod.org/files/sdk/${P}.tgz"

LICENSE="ValveSDK"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {
	find -iname '*.orig' -exec rm -f '{}' \;
}

src_install() {
	insinto "$(games_get_libdir)"/${PN}
	doins -r multiplayer singleplayer || die "doins failed"
	dodoc metamod.hlsdk-2.3.txt metamod.hlsdk-2.3.patch
	prepgamesdirs
}
