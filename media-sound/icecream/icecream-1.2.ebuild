# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/icecream/icecream-1.2.ebuild,v 1.5 2012/03/18 15:47:28 armin76 Exp $

DESCRIPTION="Extracts and records individual MP3 tracks from shoutcast streams"
HOMEPAGE="http://icecream.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-lang/perl"

src_install() {
	doman ${PN}.8
	dobin ${PN}
}
