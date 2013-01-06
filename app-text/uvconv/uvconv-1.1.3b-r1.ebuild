# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/uvconv/uvconv-1.1.3b-r1.ebuild,v 1.4 2012/06/14 09:16:18 ago Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A small utility that converts among Vietnamese charsets"
HOMEPAGE="http://unikey.org/"
SRC_URI="mirror://sourceforge/unikey/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc43.patch" \
		"${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	emake CXX="$(tc-getCXX)" OPTFLAGS="${CFLAGS}" -C uvconvert || die
}

src_install () {
	dobin uvconvert/${PN}
	doman uvconv.1
	dodoc readme.txt AUTHORS CREDITS changes.txt
}
