# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ethstatus/ethstatus-0.4.3.ebuild,v 1.2 2013/06/12 00:22:12 jer Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="ncurses based utility to display real time statistics about network traffic."
HOMEPAGE="http://packages.qa.debian.org/e/ethstatus.html"
SRC_URI="mirror://debian/pool/main/e/ethstatus/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.4-r1"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	sed -i \
		-e '/^CFLAGS/s|=|?=|g' \
		-e '/^LDFLAGS/s|=|+=|g' \
		-e 's|gcc|$(CC)|g' \
		Makefile
	tc-export CC
	LDFLAGS="$( $(tc-getPKG_CONFIG) --libs ncurses) ${LDFLAGS}"
}

src_install() {
	dobin ethstatus
	doman ethstatus.1
	dodoc CHANGELOG README
}
