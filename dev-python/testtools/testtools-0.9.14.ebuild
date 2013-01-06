# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testtools/testtools-0.9.14.ebuild,v 1.2 2012/04/26 22:14:30 aballier Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils versionator

SERIES="$(get_version_component_range 1-2)"

DESCRIPTION="Extensions to the Python unittest library"
HOMEPAGE="https://launchpad.net/testtools http://pypi.python.org/pypi/testtools"
SRC_URI="http://launchpad.net/${PN}/${SERIES}/${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	distutils_src_prepare

	# Fix tests with Python 3.
	sed -e 's/raise RuntimeError, "Something went wrong!"/raise RuntimeError("Something went wrong!")/' -i testtools/tests/test_monkey.py
}

# dev-python/subunit imports some objects from testtools.tests.helpers, so tests need to be installed.
