# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosmo-abis/libosmo-abis-0.2.0.ebuild,v 1.1 2014/04/26 02:38:16 zx2c4 Exp $

EAPI=5

inherit autotools

DESCRIPTION="Osmocom library for A-bis interface"
HOMEPAGE="http://openbsc.osmocom.org/trac/wiki/libosmo-abis"
SRC_URI="http://cgit.osmocom.org/cgit/${PN}/snapshot/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/ortp"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i "s/UNKNOWN/${PV}/" git-version-gen || die
	eautoreconf
}
