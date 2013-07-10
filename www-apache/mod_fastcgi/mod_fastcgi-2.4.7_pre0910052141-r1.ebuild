# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fastcgi/mod_fastcgi-2.4.7_pre0910052141-r1.ebuild,v 1.1 2013/07/10 02:45:54 neurogeek Exp $

EAPI="5"
inherit apache-module eutils

MY_P="${PN}-SNAP-${PV/2.4.7_pre/}"
DESCRIPTION="FastCGI is a open extension to CGI without the limitations of server specific APIs."
HOMEPAGE="http://fastcgi.com/"
SRC_URI="http://www.fastcgi.com/dist/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="mod_fastcgi"
IUSE=""

APXS2_ARGS="-c mod_fastcgi.c fcgi*.c"
APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="FASTCGI"

DOCFILES="CHANGES README docs/LICENSE.TERMS docs/mod_fastcgi.html"

S="${WORKDIR}/${MY_P}"

need_apache2

src_prepare() {
	epatch "${FILESDIR}/${PN}-compile-against-apache2.4.patch"
}
