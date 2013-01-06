# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-oauth/pecl-oauth-1.2.2.ebuild,v 1.1 2011/09/05 12:43:27 olemarkus Exp $

EAPI="2"
PHP_EXT_NAME="oauth"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="OAuth is an authorization protocol built on top of HTTP"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="dev-lang/php[hash]"
RDEPEND="${DEPEND}"
