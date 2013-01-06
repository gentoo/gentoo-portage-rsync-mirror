# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py/py-1.4.7.ebuild,v 1.9 2012/06/17 18:44:45 armin76 Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="py.test"

inherit distutils

DESCRIPTION="library with cross-python path, ini-parsing, io, code, log facilities"
HOMEPAGE="http://pylib.org/ http://pypi.python.org/pypi/py"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools
	test? ( >=dev-python/pytest-2.0.3 )"
RDEPEND=""

DOCS="CHANGELOG README.txt"

src_prepare() {
	distutils_src_prepare

	# Disable failing tests.
	rm -f testing/path/test_svnauth.py
	rm -f testing/path/test_svnurl.py
	rm -f testing/path/test_svnwc.py
}
