# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_wsgi/mod_wsgi-3.3.ebuild,v 1.5 2011/04/22 21:58:23 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="*"
PYTHON_USE_WITH="threads"

inherit apache-module eutils python

DESCRIPTION="An Apache2 module for running Python WSGI applications."
HOMEPAGE="http://code.google.com/p/modwsgi/"
SRC_URI="http://modwsgi.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="70_${PN}"
APACHE2_MOD_DEFINE="WSGI"

DOCFILES="README"

need_apache2

src_prepare() {
	epatch "${FILESDIR}/${P}-python-3.2.patch"
}

src_configure() {
	econf --with-apxs=${APXS}
}

src_compile() {
	default
}
