# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PHP_CodeCoverage/PHP_CodeCoverage-1.1.2.ebuild,v 1.3 2012/08/21 12:42:30 johu Exp $

EAPI=4

PEAR_PV="1.1.2"
PHP_PEAR_PKG_NAME="PHP_CodeCoverage"

inherit php-pear-r1

DESCRIPTION="Library that provides collection, processing, and rendering functionality for PHP code coverage information."
HOMEPAGE="pear.phpunit.de"
SRC_URI="http://pear.phpunit.de/get/PHP_CodeCoverage-1.1.2.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-php/pear-1.9.4
	>=dev-php/File_Iterator-1.3.0
	>=dev-php/PHP_TokenStream-1.1.0
	>=dev-php/Text_Template-1.1.1"
RDEPEND="${DEPEND}"
