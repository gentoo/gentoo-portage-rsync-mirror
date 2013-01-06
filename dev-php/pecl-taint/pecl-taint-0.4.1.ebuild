# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-taint/pecl-taint-0.4.1.ebuild,v 1.1 2012/02/26 07:05:50 olemarkus Exp $

EAPI=4

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

DESCRIPTION="Extension used for detecting XSS codes(tainted string)"
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_postinst() {
	elog 'In order to enable this extension, add'
	elog '  taint.enable=1'
	elog 'to /etc/php/<sapi>-<slot>/ext/taint.ini'
}
