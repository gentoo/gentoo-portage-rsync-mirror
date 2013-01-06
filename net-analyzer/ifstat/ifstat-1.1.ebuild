# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ifstat/ifstat-1.1.ebuild,v 1.16 2011/03/20 18:35:07 armin76 Exp $

inherit eutils

IUSE="snmp"

DESCRIPTION="Network interface bandwidth usage, with support for snmp targets."
SRC_URI="http://gael.roualland.free.fr/ifstat/${P}.tar.gz"
HOMEPAGE="http://gael.roualland.free.fr/ifstat/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 hppa ppc ppc64 sparc x86"

DEPEND="snmp? ( >=net-analyzer/net-snmp-5.0 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-strip_and_cflags.patch
}

src_install () {
	einstall || die
	dodoc HISTORY README TODO VERSION
}
