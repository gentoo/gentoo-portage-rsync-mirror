# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/newspost/newspost-2.1.1-r2.ebuild,v 1.6 2010/01/07 15:52:16 fauli Exp $

inherit eutils

DESCRIPTION="a usenet binary autoposter for unix"
HOMEPAGE="http://newspost.unixcab.org/"
SRC_URI="http://newspost.unixcab.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=""
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/CAN-2005-0101.patch

	# Should fix some problems with unexpected server replies, cf. bug 185468
	epatch "${FILESDIR}"/${P}-nntp.patch
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch

	sed -i \
		-e "s:OPT_FLAGS = :OPT_FLAGS = ${CFLAGS}#:" Makefile \
		|| die "sed Makefile failed"

	# We don't want pre-stripped binaries
	sed -i -e "s:-strip newspost::" Makefile || die "pre-stripping sed failed"
}

src_install () {
	dobin newspost || die "dobin failed"
	doman man/man1/newspost.1 || die "doman failed"
	dodoc README CHANGES || die "dodoc failed"
}
