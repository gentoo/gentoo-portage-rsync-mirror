# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-geoip/pecl-geoip-1.0.8-r1.ebuild,v 1.3 2012/12/04 10:57:53 ago Exp $

EAPI="4"

PHP_EXT_NAME="geoip"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README ChangeLog"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="amd64 x86"

DESCRIPTION="PHP extension to map IP address to geographic places"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/geoip-1.4.0"
RDEPEND="${DEPEND}"
