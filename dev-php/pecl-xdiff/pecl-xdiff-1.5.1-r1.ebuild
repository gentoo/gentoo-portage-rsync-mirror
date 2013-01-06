# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-xdiff/pecl-xdiff-1.5.1-r1.ebuild,v 1.1 2011/12/14 22:50:56 mabi Exp $

EAPI=3

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="xdiff"
PHP_EXT_NAME="xdiff"
PHP_EXT_INI="yes"
DOCS="README.API"

inherit php-ext-pecl-r2

DESCRIPTION="PHP extension for generating diff files"
LICENSE="PHP-2.02"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libxdiff"
RDEPEND="${DEPEND}"
