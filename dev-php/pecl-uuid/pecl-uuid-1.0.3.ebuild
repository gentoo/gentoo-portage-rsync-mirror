# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-uuid/pecl-uuid-1.0.3.ebuild,v 1.1 2012/08/24 09:01:07 olemarkus Exp $

EAPI="4"

PHP_EXT_NAME="uuid"
PHP_EXT_INIT="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CREDITS"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

DESCRIPTION="A wrapper around libuuid."
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-apps/util-linux"
RDEPEND="${DEPEND}"
