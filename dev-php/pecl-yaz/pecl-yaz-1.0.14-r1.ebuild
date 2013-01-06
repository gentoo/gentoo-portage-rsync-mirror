# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-yaz/pecl-yaz-1.0.14-r1.ebuild,v 1.1 2011/12/14 22:52:16 mabi Exp $

EAPI=3

PHP_EXT_NAME="yaz"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"

inherit php-ext-pecl-r2

KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ~ppc64 s390 sh sparc x86"

DESCRIPTION="This extension implements a Z39.50 client for PHP using the YAZ toolkit."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/yaz-3.0.2"
RDEPEND="${DEPEND}"

my_conf="--with-yaz=/usr"
