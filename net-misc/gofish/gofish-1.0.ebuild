# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gofish/gofish-1.0.ebuild,v 1.2 2007/04/22 16:35:53 phreak Exp $

inherit eutils

DESCRIPTION="Gofish gopher server"
HOMEPAGE="http://gofish.sourceforge.net"
SRC_URI="mirror://sourceforge/gofish/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

pkg_setup() {
	enewgroup gopher 30
	enewuser gopher 30 -1 -1 gopher
}

src_compile() {
	econf \
		--localstatedir=/var \
		--disable-http || die "econf failed!"

	emake || die "emake failed!"
}

src_install () {
	sed -i s/';uid = -1'/'uid = 30'/ "${S}"/gofish.conf
	sed -i s/';gid = -1'/'uid = 30'/ "${S}"/gofish.conf
	make DESTDIR="${D}" install || die "make install failed!"
	newinitd "${FILESDIR}"/gofish.rc gofish
	newconfd "${FILESDIR}"/gofish.confd gofish
}

pkg_postinst() {
	echo
	elog "Please configure /etc/${PN}.conf before attempt to use it!"
	echo
}
