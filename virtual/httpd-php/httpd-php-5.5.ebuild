# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/httpd-php/httpd-php-5.5.ebuild,v 1.11 2013/08/23 16:08:56 jer Exp $

EAPI="5"

DESCRIPTION="Virtual to provide PHP-enabled webservers"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="${PV}"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 sh sparc x86 ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="|| ( dev-lang/php:${SLOT}[fpm]
			  dev-lang/php:${SLOT}[apache2]
			  dev-lang/php:${SLOT}[cgi] )"
DEPEND=""
