# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-translit/pecl-translit-0.6.1.ebuild,v 1.1 2013/03/05 11:45:35 olemarkus Exp $

EAPI=5

PHP_EXT_NAME="translit"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Transliterates non-latin character sets to latin."
LICENSE="PHP-3"
SLOT="0"
IUSE=""
