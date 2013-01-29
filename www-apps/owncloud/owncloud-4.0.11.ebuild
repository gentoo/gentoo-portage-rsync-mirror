# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/owncloud/owncloud-4.0.11.ebuild,v 1.2 2013/01/29 13:27:36 voyageur Exp $

EAPI=4

inherit eutils webapp depend.php

DESCRIPTION="Web-based storage application where all your data is under your own control"
HOMEPAGE="http://owncloud.org"
SRC_URI="http://owncloud.org/releases/${P}.tar.bz2"
LICENSE="AGPL-3"

KEYWORDS="~amd64 ~x86"
IUSE="+curl mysql postgres +sqlite"
REQUIRED_USE="|| ( mysql postgres sqlite )"

DEPEND=""
RDEPEND="|| ( >=dev-lang/php-5.4.9[curl?,gd,hash,json,mysql?,pdo,postgres?,simplexml,sqlite?,xmlwriter,zip]
	sqlite? ( <dev-lang/php-5.4.9[curl?,gd,hash,json,mysql?,pdo,postgres?,simplexml,sqlite3,xmlwriter,zip] )
	!sqlite? (
	<dev-lang/php-5.4.9[curl?,gd,hash,json,mysql?,pdo,postgres?,simplexml,xmlwriter,zip] ) )"
need_httpd_cgi
need_php_httpd

S=${WORKDIR}/${PN}

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	local docs="README"
	dodoc ${docs}
	rm -f ${docs}

	insinto "${MY_HTDOCSDIR}"
	doins -r .
	dodir "${MY_HTDOCSDIR}"/data

	webapp_serverowned -R "${MY_HTDOCSDIR}"/apps
	webapp_serverowned -R "${MY_HTDOCSDIR}"/data
	webapp_serverowned -R "${MY_HTDOCSDIR}"/config
	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	webapp_src_install
}
