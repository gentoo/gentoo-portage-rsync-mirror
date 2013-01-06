# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_vdbh/mod_vdbh-1.0.3-r1.ebuild,v 1.1 2007/07/29 15:18:08 phreak Exp $

inherit apache-module

KEYWORDS="ppc x86"

DESCRIPTION="An Apache2 module for mass virtual hosting using a MySQL database."
HOMEPAGE="http://www.synthemesc.com/mod_vdbh/"
SRC_URI="http://www.synthemesc.com/downloads/${PN}/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
IUSE=""

S="${WORKDIR}/${PN}"

DEPEND="virtual/mysql
		>=sys-libs/zlib-1.1.4"
RDEPEND="${DEPEND}"

APXS2_ARGS="-DHAVE_STDDEF_H -I/usr/include/mysql -Wl,-lmysqlclient -c ${PN}.c"

APACHE2_MOD_CONF="21_mod_vdbh"
APACHE2_MOD_DEFINE="VDBH"

DOCFILES="AUTHORS README"

need_apache2
