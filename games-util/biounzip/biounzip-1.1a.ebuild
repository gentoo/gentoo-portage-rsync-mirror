# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/biounzip/biounzip-1.1a.ebuild,v 1.8 2008/12/06 14:41:51 nyhm Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Unpacks BioZip archives"
HOMEPAGE="http://biounzip.sourceforge.net/"
SRC_URI="mirror://sourceforge/biounzip/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${P/a/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-64bit.patch
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o ${PN} *.c -lz || die "cc failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc biozip.txt
}
