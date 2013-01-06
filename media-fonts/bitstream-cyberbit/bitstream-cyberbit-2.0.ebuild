# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/bitstream-cyberbit/bitstream-cyberbit-2.0.ebuild,v 1.4 2011/06/12 18:46:39 chithanh Exp $

EAPI="2"

inherit font

DESCRIPTION="Cyberbit Unicode (including CJK) font"
HOMEPAGE="http://www.bitstream.com/"
SRC_URI="http://http.netscape.com.edgesuite.net/pub/communicator/extras/fonts/windows/Cyberbit.ZIP -> ${P}.zip"
LICENSE="BitstreamCyberbit"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT="bindist mirror"

FONT_SUFFIX="ttf"
