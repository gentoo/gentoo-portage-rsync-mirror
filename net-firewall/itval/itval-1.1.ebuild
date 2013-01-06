# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/itval/itval-1.1.ebuild,v 1.1 2009/07/09 15:54:35 pva Exp $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="Iptables policy testing and validation tool"
HOMEPAGE="http://itval.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/ITVal-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/bison
	sys-devel/flex"
RDEPEND=""

S=${WORKDIR}/ITVal-${PV}

src_prepare() {
	epatch "${FILESDIR}/itval-1.1-gcc44.patch"
}

src_install(){
	make DESTDIR="${D}" install || die "make install failed"
	doman man/ITVal.n || die
	dodoc README ChangeLog RELEASE AUTHORS
}
