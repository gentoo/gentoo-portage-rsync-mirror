# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-apc/pecl-apc-3.1.9-r2.ebuild,v 1.8 2013/04/09 08:49:14 olemarkus Exp $

EAPI=4

PHP_EXT_NAME="apc"
PHP_EXT_PECL_PKG="APC"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CHANGELOG INSTALL NOTICE TECHNOTES.txt TODO"

PHP_EXT_INIFILE="${PN}.ini"

inherit php-ext-pecl-r2 confutils eutils

KEYWORDS="amd64 ppc ~ppc64 x86"

DESCRIPTION="A free, open, and robust framework for caching and optimizing PHP code."
LICENSE="PHP-3.01"
SLOT="0"
IUSE="mmap"

DEPEND="
	!dev-php/eaccelerator
	!dev-php/xcache
	!dev-php/pecl-apcu
	!dev-php/pecl-zendopcache
	dev-lang/php[-opcache(-)]"
RDEPEND="${DEPEND}"

LOCKS="pthreadmutex pthreadrw spinlock semaphore"

LUSE=""
for l in ${LOCKS}; do
	LUSE+="lock_${l} "
done

IUSE+=" ${LUSE/lock_pthreadmutex/+lock_pthreadmutex}"

REQUIRED_USE="^^ ( $LUSE )"

src_configure() {
	my_conf="--enable-apc"
	enable_extension_enable "apc-mmap" "mmap" 0

	enable_extension_enable "apc-pthreadmutex" "lock_pthreadmutex" 0
	enable_extension_enable "apc-pthreadrwlocks" "lock_pthreadrw" 0
	enable_extension_enable "apc-spinlocks" "lock_spinlock" 0
	enable_extension_enable "apc-sem" "lock_semaphore" 0

	php-ext-source-r2_src_configure
}

src_install() {
	php-ext-pecl-r2_src_install

	dodir "${PHP_EXT_SHARED_DIR}"
	insinto "${PHP_EXT_SHARED_DIR}"
	doins apc.php
}

pkg_postinst() {
	elog "The apc.php file shipped with this release of PECL-APC was"
	elog "installed into ${PHP_EXT_SHARED_DIR}/."
}
