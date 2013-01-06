# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/httptype/httptype-1.3.9.ebuild,v 1.8 2012/12/25 18:39:40 blueness Exp $

DESCRIPTION="Returns the http host software of a website"

HOMEPAGE="http://httptype.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-1"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
#S=${WORKDIR}/${P}

src_compile() {
	einfo "Stubbing so Makefile isn't called"
}

src_install() {
	#make PREFIX=${D}/usr install || die
	dobin httptype || die 'dobin failed'
	doman httptype.1 || die 'doman failed'
	dodoc Changelog README || die 'dodoc failed'
}
