# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Text_Template/Text_Template-1.1.1.ebuild,v 1.3 2012/08/21 12:34:48 johu Exp $

EAPI="4"

PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_URI="pear.phpunit.de"
PHP_PEAR_PN="Text_Template"

inherit php-pear-lib-r1

HOMEPAGE="http://pear.phpunit.de"

DESCRIPTION="Simple template engine"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPENDS=">=dev-php/pear-1.9.4"
