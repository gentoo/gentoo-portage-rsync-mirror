# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-zendopcache/pecl-zendopcache-7.0.1.ebuild,v 1.3 2013/09/10 03:10:22 patrick Exp $

EAPI="5"
PHP_EXT_NAME="opcache"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="yes"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64"

MY_PV="${PV/_/}"
MY_PV="${MY_PV/rc/RC}"

DESCRIPTION="The Zend Optimizer+ provides faster PHP execution through opcode caching and optimization."
LICENSE="PHP-3"
SLOT="0"
IUSE=""
