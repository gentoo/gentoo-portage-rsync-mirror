# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_ldap_userdir/mod_ldap_userdir-1.1.19.ebuild,v 1.1 2014/12/18 01:27:49 mjo Exp $

EAPI=5

inherit apache-module depend.apache

DESCRIPTION="Look up Apache ~user directories in an LDAP directory"
HOMEPAGE="http://horde.net/~jwm/software/${PN}/"
SRC_URI="http://horde.net/~jwm/software/${PN}/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl"

DEPEND="net-nds/openldap
	ssl? ( dev-libs/openssl )"

# The module will compile fine without apache[ldap], but Apache will
# crash if you try to load ${PN} without mod_ldap loaded. The funny-
# looking atom was taken from depend.apache.eclass (need_apache2).
RDEPEND="${DEPEND}
	=www-servers/apache-2*[ldap]"

APACHE2_MOD_CONF="47_${PN}"
APACHE2_MOD_DEFINE="LDAP LDAP_USERDIR"

DOCFILES="DIRECTIVES README user-ldif"

# Don't try to get away without this, even though it causes some deps to
# be repeated.
need_apache2
