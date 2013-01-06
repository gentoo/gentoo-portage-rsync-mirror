# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_access_dnsbl/mod_access_dnsbl-0.01.ebuild,v 1.3 2012/10/16 03:04:23 patrick Exp $

inherit apache-module eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="mod_access_dnsbl allows to specify access controls against a list of DNSBL zones"
HOMEPAGE="http://www.apacheconsultancy.com/modules/mod_access_dnsbl/"
SRC_URI="http://www.apacheconsultancy.com/modules/mod_access_dnsbl/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND="www-apache/mod_dnsbl_lookup"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="DNSBL"

need_apache2_2
