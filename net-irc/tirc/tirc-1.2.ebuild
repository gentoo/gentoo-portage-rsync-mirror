# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/tirc/tirc-1.2.ebuild,v 1.3 2014/11/15 12:13:28 jer Exp $

EAPI=5
inherit autotools eutils toolchain-funcs

DESCRIPTION="Token's IRC client"
HOMEPAGE="http://home.mayn.de/jean-luc/alt/tirc/"
SRC_URI="mirror://debian/pool/main/t/tirc/${PN}_${PV}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="debug"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	# Don't call dodoc on a directory, bug #367505.
	rm -rf doc/RCS || die

	epatch "${FILESDIR}"/${P}-configure.patch
	eautoreconf
}

src_configure() {
	tc-export CC
	econf \
		$(use_enable debug)
}

src_compile() {
	emake depend
	emake tirc
}

src_install() {
	dobin tirc
	doman tirc.1

	dodoc Changelog FAQ Notes README doc/*
}
