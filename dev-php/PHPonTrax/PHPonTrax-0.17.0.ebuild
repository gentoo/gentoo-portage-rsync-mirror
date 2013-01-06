# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PHPonTrax/PHPonTrax-0.17.0.ebuild,v 1.1 2012/01/19 12:02:10 mabi Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="Web-application and persistance framework based on Ruby on Rails"
HOMEPAGE="http://www.phpontrax.org/"
SRC_URI="http://pear.phpontrax.com/get/${P}.tgz"

LICENSE="MIT"
SLOT="0"
IUSE="mysql postgres sqlite"

KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/httpd-php
	dev-lang/php[session,imap]
	dev-php/PEAR-MDB2
	dev-php/PEAR-Mail
	dev-php/PEAR-Mail_Mime
	mysql? ( dev-php/PEAR-MDB2_Driver_mysql )
	postgres? ( dev-php/PEAR-MDB2_Driver_pgsql )
	sqlite? ( dev-php/PEAR-MDB2_Driver_sqlite )
	!mysql? ( !postgres? ( !sqlite? ( dev-php/PEAR-MDB2_Driver_mysql ) ) )"

pkg_postinst() {
	ewarn "This packages requires that you enable mod_rewrite in apache-2."
}
