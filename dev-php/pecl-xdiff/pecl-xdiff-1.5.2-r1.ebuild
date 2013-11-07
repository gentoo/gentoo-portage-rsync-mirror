# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-xdiff/pecl-xdiff-1.5.2-r1.ebuild,v 1.1 2013/11/07 22:28:42 mabi Exp $

EAPI=4

PHP_EXT_NAME="xdiff"
PHP_EXT_PECL_PKG="xdiff"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README.API"

USE_PHP="php5-3 php5-4 php5-5"

inherit php-ext-pecl-r2

KEYWORDS="~x86 ~amd64"

DESCRIPTION="PHP extension for generating diff files"
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

DEPEND="dev-libs/libxdiff"
RDEPEND="${DEPEND}"
