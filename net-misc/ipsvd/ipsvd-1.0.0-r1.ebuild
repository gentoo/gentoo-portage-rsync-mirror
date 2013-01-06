# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipsvd/ipsvd-1.0.0-r1.ebuild,v 1.2 2011/04/16 19:12:26 ulm Exp $

EAPI=3

inherit toolchain-funcs flag-o-matic eutils

DESCRIPTION="ipsvd is a set of internet protocol service daemons for Unix."
HOMEPAGE="http://smarden.org/ipsvd/"
SRC_URI="http://smarden.org/ipsvd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/net/${P}"

src_prepare() {
	cd "${S}"/src
	epatch "${FILESDIR}"/${P}-fix-parallel-make.diff
}

src_configure() {
	cd "${S}"/src
	if use static ; then
		append-ldflags -static
	fi

	echo "$(tc-getCC) ${CFLAGS}"  > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
}

src_compile() {
	cd "${S}"/src
	emake || die "make failed"
}

src_install() {
	dobin src/{tcpsvd,udpsvd,ipsvd-cdb} || die "dobin"
	dodoc package/{CHANGES,README}

	dohtml doc/*.html
	doman man/ipsvd-instruct.5 man/ipsvd.7 man/udpsvd.8 \
		man/tcpsvd.8 man/ipsvd-cdb.8
}
