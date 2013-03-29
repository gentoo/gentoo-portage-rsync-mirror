# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-radius/pecl-radius-1.2.5-r3.ebuild,v 1.1 2013/03/29 20:51:41 olemarkus Exp $

EAPI=5

PHP_EXT_NAME="radius"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-5 php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Provides full support for RADIUS authentication (RFC 2865) and RADIUS accounting (RFC 2866)."
LICENSE="BSD BSD-2"
SLOT="0"
IUSE="examples"

src_prepare() {
	# Remove this in the next release
	if use php_targets_php5-4 ; then
		sed -i -e 's,function_entry,zend_function_entry,' \
		"${WORKDIR}/php5.4/radius.c"
	fi
	if use php_targets_php5-5 ; then
		sed -i -e 's,function_entry,zend_function_entry,' \
		"${WORKDIR}/php5.5/radius.c"
	fi
	local slot orig_s="${PHP_EXT_S}"
	for slot in $(php_get_slots); do
		php_init_slot_env ${slot}
		epatch "${FILESDIR}/radius_long.patch"
	done
	php-ext-source-r2_src_prepare
}
