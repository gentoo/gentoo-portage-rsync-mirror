# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/linksys-tftp/linksys-tftp-1.2.1-r3.ebuild,v 1.3 2015/03/25 13:43:57 ago Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="TFTP client suitable for uploading to the Linksys WRT54G Wireless Router"
HOMEPAGE="http://redsand.net/projects/linksys-tftp/linksys-tftp.php"
SRC_URI="http://redsand.net/projects/${PN}/pub/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-r1-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin linksys-tftp
	dodoc README
}
