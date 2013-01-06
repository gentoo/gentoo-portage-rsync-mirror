# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/phpldapadmin/phpldapadmin-1.2.0.4-r1.ebuild,v 1.1 2010/07/03 15:41:09 mabi Exp $

EAPI="2"

inherit webapp depend.php

DESCRIPTION="phpLDAPadmin is a web-based tool for managing all aspects of your LDAP server."
HOMEPAGE="http://phpldapadmin.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/php[hash,ldap,session,xml,nls]
		 || ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"

need_httpd_cgi
need_php_httpd

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv config/config.php.example config/config.php
}

src_install() {
	webapp_src_preinst

	dodoc INSTALL

	insinto "${MY_HTDOCSDIR}"
	doins -r *

	webapp_configfile "${MY_HTDOCSDIR}"/config/config.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall2-en.txt

	webapp_src_install
}
