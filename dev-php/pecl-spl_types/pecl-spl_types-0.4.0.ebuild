# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-spl_types/pecl-spl_types-0.4.0.ebuild,v 1.2 2013/09/10 03:11:35 patrick Exp $

EAPI=5

PHP_EXT_NAME="spl_types"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Standard PHP library types add-on"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
