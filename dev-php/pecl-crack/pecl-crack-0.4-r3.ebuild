# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-crack/pecl-crack-0.4-r3.ebuild,v 1.4 2014/08/10 21:01:17 slyfox Exp $

EAPI="4"

PHP_EXT_NAME="crack"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="EXPERIMENTAL"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="amd64 ppc ~ppc64 ~x86"

DESCRIPTION="PHP interface to the cracklib libraries"
LICENSE="PHP-3 CRACKLIB"
SLOT="0"
IUSE=""

src_prepare() {
	local slot
	for slot in $(php_get_slots) ; do
		cd "${WORKDIR}/${slot}"
		epatch "${FILESDIR}/fix-php-5-4-support.patch"
		# Patch for http://pecl.php.net/bugs/bug.php?id=5765
		epatch "${FILESDIR}/fix-pecl-bug-5765.patch"
	done
	php-ext-source-r2_src_prepare
}
