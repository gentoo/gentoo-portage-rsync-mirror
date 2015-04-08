# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpunit/phpunit-3.7.20.ebuild,v 1.4 2013/08/10 13:21:21 ago Exp $

EAPI=5

DESCRIPTION="A PHP Unit Testing framework"
HOMEPAGE="http://phpunit.de"

PHPUNIT_PHAR="${P}.phar"

SRC_URI="http://dev.gentoo.org/~olemarkus/phpunit/${PHPUNIT_PHAR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~hppa x86"
IUSE=""

DEPEND="dev-lang/php[phar,xml]"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	return
}

src_install() {
	insinto /usr/share/php/phpunit
	insopts -m755
	newins "${DISTDIR}"/${PHPUNIT_PHAR} phpunit.phar
	dosym /usr/share/php/phpunit/phpunit.phar /usr/bin/phpunit
}

pkg_postinst() {
	elog "${PN} can optionally use json, pdo-sqlite and pdo-mysql features."
	elog "If you want those, emerge dev-lang/php with USE=\"json pdo sqlite mysql\"."
}
