# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/an/an-1.1.ebuild,v 1.8 2014/03/02 17:28:00 jer Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Very fast anagram generator with dictionary lookup"
HOMEPAGE="http://packages.debian.org/unstable/games/an"

SRC_URI="mirror://debian/pool/main/a/${PN}/${PN}_${PV}.orig.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86"
IUSE=""

DEPEND="dev-libs/icu:="
RDEPEND="
	${DEPEND}
	sys-apps/miscfiles[-minimal]
"

src_prepare() {
	sed -i \
		-e '/^CC/s|:=|?=|' \
		-e 's|$(CC) $(CFLAGS)|& $(LDFLAGS)|g' \
		Makefile || die
	tc-export CC
}

src_install() {
	dobin ${PN}
	newman ${PN}.6 ${PN}.1
	dodoc ALGORITHM
}
