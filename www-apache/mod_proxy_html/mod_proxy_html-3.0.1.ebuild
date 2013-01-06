# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_proxy_html/mod_proxy_html-3.0.1.ebuild,v 1.3 2012/05/21 09:29:31 phajdan.jr Exp $

inherit apache-module

DESCRIPTION="An Apache2 module to rewrite links in html pages behind a reverse proxy."
HOMEPAGE="http://apache.webthing.com/mod_proxy_html/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/bzip2
	dev-libs/libxml2"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="27_${PN}"
APACHE2_MOD_DEFINE="PROXY_HTML"

need_apache2

S="${WORKDIR}"/${PN}

src_compile() {
	APXS2_ARGS="$(xml2-config --cflags) -c ${PN}.c"
	apache-module_src_compile
}
