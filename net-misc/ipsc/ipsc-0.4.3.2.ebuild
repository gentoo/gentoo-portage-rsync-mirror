# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipsc/ipsc-0.4.3.2.ebuild,v 1.5 2009/09/23 19:38:10 patrick Exp $

DESCRIPTION="IP Subnet Calculator"
HOMEPAGE="http://packages.debian.org/unstable/net/ipsc"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RDEPEND=""

src_compile() {
	cd src
	emake || die "emake failed"
}

src_install() {
	dodoc README ChangeLog TODO CONTRIBUTORS
	cd src
	dobin ipsc
	doman ipsc.1
}
