# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_spin/mod_spin-1.1.9.ebuild,v 1.2 2012/10/16 03:36:34 patrick Exp $

inherit apache-module

DESCRIPTION="A simple template language, with persistent session data tracking and SQL connection pooling"
HOMEPAGE="http://rexursive.com/software/modspin"
SRC_URI="ftp://ftp.rexursive.com/pub/mod-spin/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

APACHE2_MOD_CONF="80_${PN}"
APACHE2_MOD_DEFINE="SPIN"

DOCFILES="AUTHORS ChangeLog INSTALL NEWS README"

DEPEND=">=sys-libs/db-4.2
	dev-libs/libxml2
	www-apache/libapreq2"
RDEPEND="${DEPEND}"

need_apache2_2

src_compile() {
	econf --with-apxs=${APXS} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dolib src/.libs/librxv_spin.so*
	apache-module_src_install
	doman docs/man/man3/*.3
	dohtml docs/html/*
}
