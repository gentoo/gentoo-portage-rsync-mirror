# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_lisp2/mod_lisp2-1.3.2.ebuild,v 1.3 2014/07/11 08:53:01 patrick Exp $

inherit apache-module eutils

DESCRIPTION="mod_lisp2 is an Apache2 module to easily write web applications in Common Lisp."
HOMEPAGE="http://www.fractalconcept.com/asp/html/mod_lisp.html"
SRC_URI="mirror://gentoo/${P}.c"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="LISP"

need_apache2

src_unpack() {
	mkdir -p "${S}" || die "mkdir S failed"
	cp -f "${DISTDIR}/${P}.c" "${S}/${PN}.c" || die "source copy failed"
}
