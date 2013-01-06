# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pump/pump-0.8.24-r3.ebuild,v 1.7 2011/04/15 21:41:41 ulm Exp $

inherit eutils toolchain-funcs

PATCHLEVEL="5"

DESCRIPTION="This is the DHCP/BOOTP client written by RedHat"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/p/pump/"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/p/${PN}/${PN}_${PV}-${PATCHLEVEL}.diff.gz
	mirror://gentoo/${P}-1-patches.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-libs/popt-1.5"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Apply Debians pump patchset - they fix things good :)
	epatch "${WORKDIR}/${PN}_${PV}-${PATCHLEVEL}.diff"

	for i in "${WORKDIR}/${PV}/"*; do
		epatch "${i}"
	done
}

src_compile() {
	emake CC="$(tc-getCC)" DEB_CFLAGS="-fPIC ${CFLAGS}" pump || die
}

src_install() {
	into /
	dosbin pump || die

	doman pump.8
	dodoc CREDITS

	into /usr
	dolib.a libpump.a || die
	insinto /usr/include
	doins pump.h || die
}
