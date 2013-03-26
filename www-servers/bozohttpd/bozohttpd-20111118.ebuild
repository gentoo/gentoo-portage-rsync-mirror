# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/bozohttpd/bozohttpd-20111118.ebuild,v 1.1 2013/03/26 19:54:50 tomwij Exp $

EAPI="5"

inherit eutils

DESCRIPTION="bozohttpd is a small and secure http server"
HOMEPAGE="http://www.eterna.com.au/bozohttpd/"
SRC_URI="http://www.eterna.com.au/bozohttpd/${P}.tar.bz2"
KEYWORDS="~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-libs/openssl-0.9.8o
	>=sys-apps/sed-4.2"
RDEPEND="${DEPEND}
	virtual/logger"

src_prepare()
{
	mv Makefile{.boot,}

	# Make it honor Gentoo CFLAGS
	sed -ie "s/-O/${CFLAGS}/" Makefile || sed 'Sed failed.'
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
