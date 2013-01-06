# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/wordpress/wordpress-3.4.2.ebuild,v 1.1 2012/09/06 21:42:28 radhermit Exp $

EAPI="4"

inherit webapp

DESCRIPTION="Wordpress php and mysql based CMS system"
HOMEPAGE="http://wordpress.org/"
SRC_URI="http://wordpress.org/${P/_rc/-RC}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="virtual/httpd-php
	|| ( dev-lang/php[mysql] dev-lang/php[mysqli] )"

S=${WORKDIR}/${PN}

need_httpd_cgi

src_install() {
	webapp_src_preinst

	dohtml readme.html
	rm -f readme.html license.txt

	[ -f wp-config.php ] || cp wp-config-sample.php wp-config.php

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned "${MY_HTDOCSDIR}"/index.php
	webapp_serverowned "${MY_HTDOCSDIR}"/wp-admin/menu.php
	webapp_serverowned "${MY_HTDOCSDIR}"

	webapp_configfile  "${MY_HTDOCSDIR}"/wp-config.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade-en.txt

	webapp_src_install
}
