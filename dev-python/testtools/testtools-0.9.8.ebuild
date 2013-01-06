# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testtools/testtools-0.9.8.ebuild,v 1.9 2011/04/16 16:03:55 armin76 Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils versionator

SERIES="$(get_version_component_range 1-2)"

DESCRIPTION="Extensions to the Python unittest library"
HOMEPAGE="https://launchpad.net/testtools http://pypi.python.org/pypi/testtools"
SRC_URI="http://launchpad.net/${PN}/${SERIES}/${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	distutils_src_prepare

	# Fix tests with Python 3.
	sed -e 's/raise RuntimeError, "Something went wrong!"/raise RuntimeError("Something went wrong!")/' -i testtools/tests/test_monkey.py
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" -m testtools.run testtools.tests.test_suite
	}
	python_execute_function testing
}

# dev-python/subunit imports some objects from testtools.tests.helpers, so tests need to be installed.
