# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/awl/awl-0.55.ebuild,v 1.2 2015/02/15 03:32:31 grknight Exp $

EAPI=5

inherit eutils

DESCRIPTION="Andrew McMillan's Web Libraries"
HOMEPAGE="https://gitlab.com/davical-project/awl"
SRC_URI="${HOMEPAGE}/repository/archive.tar.gz?ref=r${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="doc? ( dev-php/PEAR-PhpDocumentor )
	test? ( dev-php/phpunit )"
RDEPEND="dev-lang/php:*[pdo,postgres,xml]"
S="${WORKDIR}/${PN}.git"

src_compile() {
	if use doc ; then
		ebegin "Generating documentation"
		phpdoc -c "docs/api/phpdoc.ini" || die "Documentation failed to build"
	fi
}

src_test() {
	phpunit tests/ || die "test suite failed"
}

src_install() {
	dodoc debian/changelog
	use doc && dohtml -r "docs/api/"
	insinto "/usr/share/php/${PN}"
	doins -r dba inc
}
