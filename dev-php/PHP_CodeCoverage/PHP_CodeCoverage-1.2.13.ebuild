# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PHP_CodeCoverage/PHP_CodeCoverage-1.2.13.ebuild,v 1.5 2014/04/26 18:55:10 ago Exp $

EAPI=5

PHP_PEAR_URI="pear.phpunit.de"

inherit php-pear-r1

DESCRIPTION="Provides collection, processing, and rendering functionality for PHP code coverage information."
HOMEPAGE="pear.phpunit.de"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

DEPEND=">=dev-php/pear-1.9.4"
RDEPEND="${DEPEND}
	>=dev-php/File_Iterator-1.3.0
	>=dev-php/PHP_TokenStream-1.1.3
	>=dev-php/Text_Template-1.1.1"
