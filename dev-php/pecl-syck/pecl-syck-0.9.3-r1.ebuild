# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-syck/pecl-syck-0.9.3-r1.ebuild,v 1.1 2011/12/14 22:48:04 mabi Exp $

EAPI="2"

PHP_EXT_NAME="syck"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CHANGELOG TODO"

inherit php-ext-pecl-r2

KEYWORDS="amd64 ~arm ppc ppc64 x86"

DESCRIPTION="PHP bindings for Syck - reads and writes YAML with it."
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

DEPEND="dev-libs/syck
		|| ( <dev-lang/php-5.3.1[hash,spl] >=dev-lang/php-5.3.1[hash] )"
RDEPEND="${DEPEND}"
