# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-htscanner/pecl-htscanner-1.0.0.ebuild,v 1.1 2011/12/14 22:37:55 mabi Exp $

EAPI="3"

PHP_EXT_NAME="htscanner"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"
PHPSAPILIST="cgi"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Enables .htaccess options for php-scripts running as cgi."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="dev-lang/php[cgi]"
RDEPEND="${DEPEND}"

my_conf="--enable-htscanner"

src_install() {
	php-ext-pecl-r2_src_install

	php-ext-source-r2_addtoinifiles "config_file" ".htaccess"
	php-ext-source-r2_addtoinifiles "default_docroot" "/"
	php-ext-source-r2_addtoinifiles "default_ttl" "300"
	php-ext-source-r2_addtoinifiles "stop_on_error" "0"
}
