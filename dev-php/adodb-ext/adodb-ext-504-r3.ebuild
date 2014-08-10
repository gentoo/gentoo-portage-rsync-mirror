# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/adodb-ext/adodb-ext-504-r3.ebuild,v 1.2 2014/08/10 20:59:14 slyfox Exp $

EAPI="5"

PHP_EXT_NAME="adodb"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

S="${WORKDIR}/adodb-${PV}"

inherit eutils php-ext-source-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension providing up to 100% speedup by replacing parts of ADOdb with C code"
HOMEPAGE="http://adodb.sourceforge.net/"
SRC_URI="http://phplens.com/lens/dl/${P}.zip"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND=">=dev-php/adodb-4.70"
DEPEND="${RDEPEND}
		app-arch/unzip"

src_prepare() {
	if use php_targets_php5-3 ; then
		cd "${WORKDIR}/php5.3"
		edos2unix "${WORKDIR}/php5.3/adodb.c"
		epatch "${FILESDIR}/php53.patch"
		cd "${S}"
	fi
	php-ext-source-r2_src_prepare
}

src_install() {
	php-ext-source-r2_src_install

	dodir "${PHP_EXT_SHARED_DIR}"
	insinto "${PHP_EXT_SHARED_DIR}"
	doins test-adodb.php

	dodoc CREDITS README.txt
}
