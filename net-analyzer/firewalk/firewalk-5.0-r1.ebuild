# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/firewalk/firewalk-5.0-r1.ebuild,v 1.5 2012/01/15 15:23:34 phajdan.jr Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A tool for determining a firewall's rule set"
HOMEPAGE="http://packetfactory.openwall.net/projects/firewalk/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.1
	>=dev-libs/libdnet-1.7"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Firewalk"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc3.4.diff
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	doman man/firewalk.8
	dodoc README TODO BUGS
}
