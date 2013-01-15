# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_kerb/mod_auth_kerb-5.4-r1.ebuild,v 1.2 2013/01/15 21:32:01 pacho Exp $

inherit apache-module eutils

DESCRIPTION="An Apache authentication module using Kerberos."
HOMEPAGE="http://modauthkerb.sourceforge.net/"
SRC_URI="mirror://sourceforge/modauthkerb/${P}.tar.gz"

LICENSE="BSD openafs-krb5-a HPND"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/krb5"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="11_${PN}"
APACHE2_MOD_DEFINE="AUTH_KERB"

DOCFILES="INSTALL README"

need_apache2_2

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-rcopshack.patch
	epatch "${FILESDIR}"/${P}-fixes.patch
	epatch "${FILESDIR}"/${P}-s4u2proxy-r1.patch
	epatch "${FILESDIR}"/${P}-httpd24.patch
	epatch "${FILESDIR}"/${P}-delegation.patch
	epatch "${FILESDIR}"/${P}-cachedir.patch
}

src_compile() {
	CFLAGS="" APXS="${APXS}" econf --with-krb5=/usr --without-krb4 || die "econf failed"
	emake || die "emake failed"
}
