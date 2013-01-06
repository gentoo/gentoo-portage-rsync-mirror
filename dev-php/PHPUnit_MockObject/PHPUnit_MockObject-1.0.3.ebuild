# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PHPUnit_MockObject/PHPUnit_MockObject-1.0.3.ebuild,v 1.3 2012/07/03 14:46:12 mabi Exp $

EAPI="2"
PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_PN="PHPUnit_MockObject"

inherit php-pear-lib-r1

KEYWORDS="amd64 x86"

DESCRIPTION="Mock Object library for PHPUnit"
HOMEPAGE="http://www.phpunit.de/"
SRC_URI="http://pear.phpunit.de/get/PHPUnit_MockObject-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-php/PEAR-PEAR-1.9.1"
RDEPEND="${DEPEND}
	dev-php/Text_Template"

S="${WORKDIR}/PHPUnit_MockObject-${PV}"
