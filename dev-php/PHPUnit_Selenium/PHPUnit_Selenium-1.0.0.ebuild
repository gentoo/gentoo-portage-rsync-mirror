# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PHPUnit_Selenium/PHPUnit_Selenium-1.0.0.ebuild,v 1.3 2012/07/03 14:48:34 mabi Exp $

EAPI="2"
PHP_PEAR_PN="PHPUnit_Selenium"
PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Selenium RC integration for PHPUnit"
HOMEPAGE="http://www.phpunit.de/"
SRC_URI="http://pear.phpunit.de/get/PHPUnit_Selenium-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="!dev-php4/phpunit
	>=dev-php/PEAR-PEAR-1.9.1"
RDEPEND="${DEPEND}
	>=dev-lang/php-5.2[simplexml,xml,tokenizer]
	|| ( <dev-lang/php-5.3[pcre,reflection,spl] >=dev-lang/php-5.3 )
	>=dev-php/PEAR-Testing_Selenium-0.2.0"

S="${WORKDIR}/PHPUnit_Selenium-${PV}"
