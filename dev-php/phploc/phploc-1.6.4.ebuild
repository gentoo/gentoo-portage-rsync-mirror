# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phploc/phploc-1.6.4.ebuild,v 1.1 2012/03/10 16:31:13 olemarkus Exp $

EAPI=4

PEAR_PV="1.6.4"
PHP_PEAR_PKG_NAME="phploc"

inherit php-pear-r1

DESCRIPTION="A tool for quickly measuring the size of a PHP project."
HOMEPAGE="http://pear.phpunit.de"
SRC_URI="http://pear.phpunit.de/get/phploc-1.6.4.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/php[tokenizer]
	>=dev-lang/php-5.2.7
	>=dev-php/PEAR-PEAR-1.9.4
	>=dev-php/File_Iterator-1.3.0
	>=dev-php/ezc-ConsoleTools-1.6"
RDEPEND="${DEPEND}"
