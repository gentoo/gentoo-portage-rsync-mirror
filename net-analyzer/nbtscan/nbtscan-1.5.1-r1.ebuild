# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nbtscan/nbtscan-1.5.1-r1.ebuild,v 1.14 2010/09/15 01:24:39 jer Exp $

inherit eutils

DESCRIPTION="NBTscan is a program for scanning IP networks for NetBIOS name information"
HOMEPAGE="http://www.inetcat.net/software/nbtscan.html"
SRC_URI="http://www.sourcefiles.org/Networking/Tools/Miscellanenous/${P}.tar.gz"
SRC_URI="http://www.inetcat.net/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

S=${WORKDIR}/${P}a

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-script-whitespace.patch
}

src_install () {
	dobin nbtscan || die
	dodoc ChangeLog README
}
