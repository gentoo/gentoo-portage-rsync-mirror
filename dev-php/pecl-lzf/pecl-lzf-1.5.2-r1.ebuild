# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-lzf/pecl-lzf-1.5.2-r1.ebuild,v 1.1 2011/12/14 22:40:38 mabi Exp $

EAPI=3

PHP_EXT_NAME="lzf"
PHP_EXT_PECL_PKG="LZF"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README ChangeLog"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="This package handles LZF de/compression."
LICENSE="PHP-3"
SLOT="0"
IUSE=""
