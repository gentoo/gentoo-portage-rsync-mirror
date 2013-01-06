# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_backtrace/mod_backtrace-0.0.1-r1.ebuild,v 1.1 2012/10/16 07:19:01 patrick Exp $

EAPI="4"

inherit apache-module eutils confutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Apache2 modules to debug segmentation faults in threads"
HOMEPAGE="http://people.apache.org/~trawick/exception_hook.html"
SRC_URI="mirror://gentoo/${P}.c"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND="www-servers/apache[debug]"
RDEPEND=""

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="BACKTRACE"

need_apache2

src_unpack() {
	mkdir -p "${S}" || die "mkdir S failed"
	cp -f "${DISTDIR}/${P}.c" "${S}/${PN}.c" || die "source copy failed"
}
