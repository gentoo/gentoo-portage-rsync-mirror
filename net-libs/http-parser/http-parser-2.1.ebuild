# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/http-parser/http-parser-2.1.ebuild,v 1.1 2013/06/30 20:27:31 hasufell Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="A parser for HTTP messages written in C. It parses both requests and responses"
HOMEPAGE="https://github.com/joyent/http-parser"
SRC_URI="https://github.com/joyent/http-parser/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-flags.patch
}

src_compile() {
	tc-export CC
	emake library
}

src_install() {
	doheader http_parser.h
	dolib.so libhttp_parser.so
	newdoc README.md README
}
