# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-libevent/pecl-libevent-0.1.0-r1.ebuild,v 1.1 2013/08/15 13:35:53 olemarkus Exp $

EAPI=5
PHP_EXT_NAME="libevent"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-5 php5-4"
inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP wrapper for libevent"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libevent-1.4.0"
RDEPEND="${DEPEND}"
