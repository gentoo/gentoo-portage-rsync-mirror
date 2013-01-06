# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_xsendfile/mod_xsendfile-0.9.ebuild,v 1.3 2010/05/21 18:54:21 pacho Exp $

inherit apache-module

DESCRIPTION="Apache2 module that processes X-SENDFILE headers registered by the original output handler"
HOMEPAGE="http://tn123.ath.cx/mod_xsendfile/"
SRC_URI="http://tn123.ath.cx/mod_xsendfile/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="50_${PN}"
APACHE2_MOD_DEFINE="XSENDFILE"

DOCFILES="Readme.html"

need_apache2
