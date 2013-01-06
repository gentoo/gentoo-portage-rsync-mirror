# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/bozohttpd/bozohttpd-20100621.ebuild,v 1.2 2010/09/04 01:46:42 phajdan.jr Exp $

inherit eutils

DESCRIPTION="bozohttpd is a small and secure http server"
HOMEPAGE="http://www.eterna.com.au/bozohttpd/"
SRC_URI="http://www.eterna.com.au/bozohttpd/${P}.tar.bz2"
KEYWORDS="~ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DEPEND=">=dev-libs/openssl-0.9.8o
	>=sys-apps/sed-4.2"
RDEPEND="${DEPEND}
	virtual/logger"

src_unpack()
{
	unpack ${A}
	cd "${S}"

	# Rename Makefile
	mv Makefile.boot Makefile

	# Make it honour Gentoo CFLAGS
	sed -ie "s/-O/${CFLAGS}/" Makefile
}

src_install ()
{
	dobin bozohttpd
	doman bozohttpd.8

	newconfd "${FILESDIR}"/${PN}.conffile   bozohttpd
	newinitd "${FILESDIR}"/${PN}.initscript bozohttpd
}

pkg_postinst()
{
	einfo "Remember to edit /etc/conf.d/bozohttpd to suit your needs."
}
