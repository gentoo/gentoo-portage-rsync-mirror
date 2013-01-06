# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pathload/pathload-1.3.2.ebuild,v 1.1 2007/05/23 08:37:50 jokey Exp $

DESCRIPTION="Non-intrusive utility for estimation of available bandwidth of Internet paths"
HOMEPAGE="http://www-static.cc.gatech.edu/fac/Constantinos.Dovrolis/pathload.html"
SRC_URI="http://www-static.cc.gatech.edu/fac/Constantinos.Dovrolis/pathload.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}_${PV}

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	dobin "${S}"/pathload_snd
	dobin "${S}"/pathload_rcv
}
