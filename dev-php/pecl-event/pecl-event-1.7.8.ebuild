# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-event/pecl-event-1.7.8.ebuild,v 1.1 2013/09/22 09:40:17 hwoarang Exp $

EAPI=4
PHP_EXT_NAME="event"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CREDITS EXPERIMENTAL INSTALL.md README.md LICENSE"

USE_PHP="php5-4 php5-5"
inherit php-ext-pecl-r2 confutils eutils

KEYWORDS="~amd64 ~x86"
LICENSE="PHP-3.01"

DESCRIPTION="PHP wrapper for libevent2"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-libs/libevent-2.0.2
	!dev-php/pecl-libevent
	sockets? ( dev-lang/php[sockets] )"
RDEPEND="${DEPEND}"

IUSE="debug +extra +ssl threads +sockets examples"

src_configure() {
	my_conf="--with-event-core"
	enable_extension_enable "event-debug" "debug" 0

	enable_extension_with "event-extra" "extra" 1
	enable_extension_with "event-openssl" "ssl" 1
	enable_extension_with "event-pthreads" "threads" 0
	enable_extension_enable "event-sockets" "sockets" 1

	php-ext-source-r2_src_configure
}
