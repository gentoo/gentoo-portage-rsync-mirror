# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_transform/mod_transform-0.6.0.ebuild,v 1.4 2012/10/12 08:59:28 patrick Exp $

inherit apache-module

KEYWORDS="amd64 ppc x86"

DESCRIPTION="Filter module that allows Apache2 to do dynamic XSL transformations."
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_transform/"
SRC_URI="http://www.outoforder.cc/downloads/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libxslt-1.1.5
		>=dev-libs/libxml2-2.6.11"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="TRANSFORM"

need_apache2_2

src_compile() {
	econf --with-apxs=${APXS} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	mv -f "src/.libs/libmod_transform.so" "src/.libs/${PN}.so" || die "mv failed"
	apache-module_src_install
}
