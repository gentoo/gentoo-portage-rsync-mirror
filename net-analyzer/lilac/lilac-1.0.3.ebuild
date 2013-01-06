# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lilac/lilac-1.0.3.ebuild,v 1.1 2010/07/21 17:24:28 dertobi123 Exp $

EAPI=2

inherit eutils webapp depend.php

DESCRIPTION="Web-based configuration tool written to configure Nagios"
HOMEPAGE="http://www.lilacplatform.com"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="nmap"

RDEPEND=">=virtual/mysql-5.0
	>=net-analyzer/nagios-3.0
	>=dev-php/PEAR-PEAR-1.6.1
	dev-lang/php[curl,json,mysql,pcntl,pdo,posix,simplexml]
	nmap? ( >=net-analyzer/nmap-4.76 )"

need_php_httpd

S="${WORKDIR}"/${P}

src_install() {
	webapp_src_preinst

	dodoc INSTALL UPGRADING
	rm -f INSTALL UPGRADING

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR}"/includes/lilac-conf.php.dist
	webapp_serverowned "${MY_HTDOCSDIR}"/includes/lilac-conf.php.dist
	webapp_src_install
}
