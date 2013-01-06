# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/libvirt-php/libvirt-php-9999.ebuild,v 1.4 2012/11/05 06:13:37 dev-zero Exp $

EAPI=4

PHP_EXT_NAME="libvirt-php"
PHP_EXT_SKIP_PHPIZE="yes"
USE_PHP="php5-3 php5-4"

inherit php-ext-source-r2 git-2

DESCRIPTION="PHP 5 bindings for libvirt."
HOMEPAGE="http://libvirt.org/php/"
EGIT_REPO_URI="git://libvirt.org/libvirt-php.git"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="app-emulation/libvirt
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	doc? ( app-text/xhtml1 )"

RESTRICT="test"

EGIT_BOOTSTRAP="autogen.sh"

src_unpack() {
	git-2_src_unpack
	# create the default modules directory to be able
	# to use the php-ext-source-r2 eclass to configure/build
	ln -s src "${S}/modules"

	for slot in $(php_get_slots); do
		cp -r "${S}" "${WORKDIR}/${slot}"
	done
}

src_install() {
	for slot in $(php_get_slots); do
		php_init_slot_env ${slot}
		insinto "${EXT_DIR}"
		newins "src/${PHP_EXT_NAME}.so" "${PHP_EXT_NAME}.so"
	done
	php-ext-source-r2_createinifiles
	dodoc AUTHORS ChangeLog NEWS README
	use doc && dohtml docs/* docs/graphics/*
}
