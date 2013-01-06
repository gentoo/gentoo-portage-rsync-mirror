# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-oauth/pecl-oauth-1.2.2-r1.ebuild,v 1.1 2012/03/06 08:59:47 olemarkus Exp $

EAPI="4"
PHP_EXT_NAME="oauth"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="OAuth is an authorization protocol built on top of HTTP"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="dev-lang/php[hash]"
RDEPEND="${DEPEND}"
