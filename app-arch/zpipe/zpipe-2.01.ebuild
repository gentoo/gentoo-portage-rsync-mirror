# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zpipe/zpipe-2.01.ebuild,v 1.2 2014/12/27 14:57:23 bircoph Exp $

EAPI=3
inherit toolchain-funcs

MY_P=${PN}.${PV/./}
DESCRIPTION="Pipe compressor/decompressor for ZPAQ"
HOMEPAGE="http://mattmahoney.net/dc/zpaq.html"
SRC_URI="http://mattmahoney.net/dc/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-arch/libzpaq"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_compile() {
	emake CXX=$(tc-getCXX) LDLIBS=-lzpaq ${PN} || die
}

src_install() {
	dobin ${PN} || die
}
