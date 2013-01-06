# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/newspost/newspost-2.1.1-r1.ebuild,v 1.5 2009/09/23 19:45:31 patrick Exp $

inherit eutils

DESCRIPTION="a usenet binary autoposter for unix"
HOMEPAGE="http://newspost.unixcab.org/"
SRC_URI="http://newspost.unixcab.org/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

# NOTE: This package should work on PPC but not tested!
# It also has a solaris make file but we don't do solaris.
# but it should mean that it is 64bit clean.
KEYWORDS="amd64 ppc x86"

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/CAN-2005-0101.patch

	sed -i \
		-e "s:OPT_FLAGS = :OPT_FLAGS = ${CFLAGS}#:" Makefile \
		|| die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	dobin newspost || die "dobin failed"
	doman man/man1/newspost.1 || die "doman failed"
	dodoc README CHANGES || die "dodoc failed"
}
