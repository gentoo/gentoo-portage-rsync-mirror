# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-syck/pecl-syck-0.9.3-r2.ebuild,v 1.5 2012/12/08 15:53:32 ago Exp $

EAPI="4"

PHP_EXT_NAME="syck"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CHANGELOG TODO"

USE_PHP="php5-4 php5-3"
inherit php-ext-pecl-r2

KEYWORDS="amd64 ~arm ppc ppc64 x86"

DESCRIPTION="PHP bindings for Syck - reads and writes YAML with it."
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

DEPEND="dev-libs/syck
		|| ( <dev-lang/php-5.3.1[hash,spl] >=dev-lang/php-5.3.1[hash] )"
RDEPEND="${DEPEND}"

src_prepare() {
	local slot
	for slot in $(php_get_slots); do
		php_init_slot_env ${slot}
		epatch "${FILESDIR}"/fix-php-5-4-support.patch
	done
	php-ext-source-r2_src_prepare
}
