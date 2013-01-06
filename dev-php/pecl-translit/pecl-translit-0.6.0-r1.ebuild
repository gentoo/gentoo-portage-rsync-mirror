# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-translit/pecl-translit-0.6.0-r1.ebuild,v 1.1 2011/12/14 22:48:55 mabi Exp $

EAPI=3

PHP_EXT_NAME="translit"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Transliterates non-latin character sets to latin."
LICENSE="PHP-3"
SLOT="0"
IUSE=""
