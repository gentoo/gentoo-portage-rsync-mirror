# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gofish/gofish-1.2.ebuild,v 1.2 2012/06/22 11:05:59 ago Exp $

EAPI=2

inherit eutils

DESCRIPTION="Gofish gopher server"
HOMEPAGE="http://gofish.sourceforge.net"
SRC_URI="mirror://sourceforge/gofish/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}

pkg_setup() {
	enewgroup gopher
	enewuser gopher -1 -1 -1 gopher
}

src_configure() {
	econf \
		--localstatedir=/var \
		--disable-mmap-cache || die
}

src_install () {
	make DESTDIR="${D}" install || die

	newinitd "${FILESDIR}"/gofish.rc gofish || die
	newconfd "${FILESDIR}"/gofish.confd gofish || die

	dodoc AUTHORS ChangeLog Configure_GoFish README TODO || die
}
