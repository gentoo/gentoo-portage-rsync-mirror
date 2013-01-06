# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/radiusclient-ng/radiusclient-ng-0.5.6.ebuild,v 1.7 2009/03/03 21:05:37 mrness Exp $

DESCRIPTION="RadiusClient NextGeneration - library for RADIUS clients accompanied with several client utilities"
HOMEPAGE="http://developer.berlios.de/projects/radiusclient-ng/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="!net-dialup/radiusclient
	!net-dialup/freeradius-client"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README BUGS CHANGES COPYRIGHT
	dohtml doc/instop.html
}
