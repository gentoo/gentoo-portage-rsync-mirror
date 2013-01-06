# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sniffit/sniffit-0.3.7-r3.ebuild,v 1.2 2012/12/05 15:40:36 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_P="${P/-/.}.beta"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Interactive Packet Sniffer"
SRC_URI="http://reptile.rug.ac.be/~coder/${PN}/files/${MY_P}.tar.gz
	 mirror://debian/pool/main/s/${PN}/${PN}_0.3.7.beta-15.diff.gz"
HOMEPAGE="http://reptile.rug.ac.be/~coder/sniffit/sniffit.html"

DEPEND="net-libs/libpcap
	>=sys-libs/ncurses-5.2"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

#S="${WORKDIR}"/${P/-/.}.beta

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-flags.patch \
		"${FILESDIR}"/${P}-misc.patch
}

src_configure() {
	tc-export CC
	econf || die
}

src_install () {
	dobin sniffit

	doman sniffit.5 sniffit.8
	dodoc README* PLUGIN-HOWTO BETA* HISTORY
}
