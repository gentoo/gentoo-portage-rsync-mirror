# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-drizzle/pecl-drizzle-0.4.2-r2.ebuild,v 1.2 2012/08/23 15:59:13 olemarkus Exp $

EAPI="4"

PHP_EXT_NAME="drizzle"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r2

KEYWORDS="~amd64"

DESCRIPTION="PHP extension using libdrizzle library to provide communcation with Drizzle and MySQL databases"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="dev-db/drizzle"
RDEPEND="${DEPEND}"
