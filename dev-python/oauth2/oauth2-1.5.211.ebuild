# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oauth2/oauth2-1.5.211.ebuild,v 1.1 2012/01/29 00:18:03 weaver Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Library for OAuth version 1.0"
HOMEPAGE="http://pypi.python.org/pypi/oauth2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="test"

RDEPEND="dev-python/httplib2"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? (
		dev-python/coverage
		dev-python/mock
	)"

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/tests"
	}
	python_execute_function -q delete_tests
}
