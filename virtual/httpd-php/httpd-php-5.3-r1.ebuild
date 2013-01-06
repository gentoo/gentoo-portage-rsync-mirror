# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/httpd-php/httpd-php-5.3-r1.ebuild,v 1.1 2012/11/04 08:08:30 olemarkus Exp $

EAPI="2"

DESCRIPTION="Virtual to provide PHP-enabled webservers"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="5.3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="|| ( =dev-lang/php-5.3*[fpm]
			  =dev-lang/php-5.3*[apache2]
			  =dev-lang/php-5.3*[cgi] )"
DEPEND=""
