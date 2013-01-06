# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-crack/pecl-crack-0.4-r1.ebuild,v 1.1 2011/12/14 22:32:31 mabi Exp $

EAPI="3"

PHP_EXT_NAME="crack"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="EXPERIMENTAL"

inherit php-ext-pecl-r2

KEYWORDS="amd64 ~ppc ~ppc64 x86"

DESCRIPTION="PHP interface to the cracklib libraries."
LICENSE="PHP-3 CRACKLIB"
SLOT="0"
IUSE=""

src_prepare() {
	for slot in $(php_get_slots) ; do
		cd "${WORKDIR}/${slot}"
		# Patch for http://pecl.php.net/bugs/bug.php?id=5765
		epatch "${FILESDIR}/fix-pecl-bug-5765.patch"
	done
	php-ext-source-r2_src_prepare
}
