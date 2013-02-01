# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sniffit/sniffit-0.3.7-r4.ebuild,v 1.4 2013/01/31 23:12:13 ago Exp $

EAPI=4
inherit eutils toolchain-funcs

MY_P="${P/-/.}.beta"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Interactive Packet Sniffer"
SRC_URI="http://reptile.rug.ac.be/~coder/${PN}/files/${MY_P}.tar.gz"
HOMEPAGE="http://reptile.rug.ac.be/~coder/sniffit/sniffit.html"

DEPEND="net-libs/libpcap
	>=sys-libs/ncurses-5.2"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

#S="${WORKDIR}"/${P/-/.}.beta

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-flags.patch \
		"${FILESDIR}"/${P}-misc.patch
	tc-export CC
}

src_install () {
	dosbin sniffit

	doman sniffit.5 sniffit.8
	dodoc README* PLUGIN-HOWTO BETA* HISTORY
}
