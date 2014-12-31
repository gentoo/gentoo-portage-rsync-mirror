# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-redmine-api/php-redmine-api-1.5.2.ebuild,v 1.1 2014/12/30 23:07:56 mjo Exp $

EAPI=5

DESCRIPTION="A simple, object-oriented, PHP Redmine API client"
HOMEPAGE="https://github.com/kbsali/${PN}"
SRC_URI="https://github.com/kbsali/${PN}/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-lang/php[curl,json,simplexml]"
DEPEND="test? ( ${RDEPEND} >=dev-php/phpunit-4 )"

src_install() {
	insinto "/usr/share/php/${PN}"
	doins -r lib

	dodoc example.php README.markdown
}

src_test() {
	phpunit || die "test suite failed"
}

pkg_postinst() {
	elog "${PN} has been installed in /usr/share/php/${PN}/."
	elog "To use it in a script, require('${PN}/lib/autoload.php'), and then"
	elog "use the Redmine\\Client class normally. Most of the examples in the"
	elog "documentation should work without modification."
}
