# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-dbx/pecl-dbx-1.1.2.ebuild,v 1.1 2012/01/15 16:51:30 olemarkus Exp $

EAPI="3"

PHP_EXT_NAME="dbx"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

# package does not support php5.3, version 1.1.1 will
USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DESCRIPTION="The dbx module is a database abstraction layer."
LICENSE="PHP-3"
SLOT="0"
IUSE=""
