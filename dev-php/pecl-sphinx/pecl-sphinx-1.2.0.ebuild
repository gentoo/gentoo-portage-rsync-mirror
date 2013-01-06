# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-sphinx/pecl-sphinx-1.2.0.ebuild,v 1.1 2012/08/26 05:28:27 olemarkus Exp $

EAPI="4"

PHP_EXT_NAME="sphinx"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-3 php5-4"

DOCS="README ChangeLog"

inherit php-ext-pecl-r2

KEYWORDS="~amd64"

DESCRIPTION="PHP extension to execute search queries on a sphinx daemon"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="${RDEPEND}
	>=dev-util/re2c-0.13"
RDEPEND="app-misc/sphinx"
