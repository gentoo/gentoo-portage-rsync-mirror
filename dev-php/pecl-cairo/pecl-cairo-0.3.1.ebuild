# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-cairo/pecl-cairo-0.3.1.ebuild,v 1.3 2012/04/13 19:00:41 ulm Exp $

EAPI="4"

PHP_EXT_NAME="cairo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="TODO"

USE_PHP="php5-3 php5-4"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Cairo bindings for PHP"
LICENSE="PHP-3.01"
SLOT="0"

DEPEND=">=x11-libs/cairo-1.4[svg]"
RDEPEND="${DEPEND}"

IUSE=""

src_unpack()  {

	unpack ${A}
	#Cairo is very silly.
	mv "${WORKDIR}/Cairo-${MY_PV}" "${WORKDIR}/cairo-${MY_PV}" || die "Failed to move"
	local slot orig_s="${PHP_EXT_S}"
	for slot in $(php_get_slots); do
		cp -r "${orig_s}" "${WORKDIR}/${slot}" || die "Failed to copy source ${orig_s} to PHP target directory"
	done

}
