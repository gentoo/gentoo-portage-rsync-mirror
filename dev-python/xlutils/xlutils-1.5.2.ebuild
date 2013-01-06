# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xlutils/xlutils-1.5.2.ebuild,v 1.4 2012/12/03 21:29:15 bicatali Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_TESTS_RESTRICTED_ABIS="*-pypy-*"
DISTUTILS_SRC_TEST=py.test
inherit distutils

DESCRIPTION="provides a collection of utilities for working with Excel files"
HOMEPAGE="http://pypi.python.org/pypi/xlutils"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

LICENSE="MIT"
SLOT="0"

DOCS=( xlutils/readme.txt xlutils/docs/*.txt )

RDEPEND=">=dev-python/xlwt-0.7.3
	>=dev-python/xlrd-0.7.7"
DEPEND="${RDEPEND}
	test? ( dev-python/errorhandler
	dev-python/mock
	>=dev-python/testfixtures-1.6.1 )"

src_test() {
	# Point distutils_src_test to tests
	distutils_src_test xlutils/tests
}

src_install() {
	distutils_src_install
	docompress -x usr/share/doc/${P}/
	dodoc ${DOCS[@]}
}
