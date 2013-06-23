# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpunit/phpunit-3.6.11.ebuild,v 1.2 2013/06/23 14:03:46 jer Exp $

EAPI=4

PEAR_PV="3.6.11"
PHP_PEAR_PKG_NAME="PHPUnit"

inherit php-pear-r1

DESCRIPTION="The PHP Unit Testing framework."
HOMEPAGE="pear.phpunit.de"
SRC_URI="http://pear.phpunit.de/get/PHPUnit-3.6.11.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND="dev-lang/php[xml]
	>=dev-php/pear-1.9.4
	>=dev-php/File_Iterator-1.3.0
	>=dev-php/Text_Template-1.1.1
	>=dev-php/PHP_CodeCoverage-1.1.0
	>=dev-php/PHP_Timer-1.0.1
	>=dev-php/PHPUnit_MockObject-1.1.0
	>=dev-php/YAML-1.0.2"
RDEPEND="${DEPEND}"

pkg_postinst() {
	elog "${PN} can optionally use json, pdo-sqlite and pdo-mysql features."
	elog "If you want those, emerge dev-lang/php with USE=\"json pdo sqlite mysql\"."
}
