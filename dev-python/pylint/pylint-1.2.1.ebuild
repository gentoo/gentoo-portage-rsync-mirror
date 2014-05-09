# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylint/pylint-1.2.1.ebuild,v 1.2 2014/05/09 05:21:12 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Python code static checker"
HOMEPAGE="http://www.logilab.org/project/pylint http://pypi.python.org/pypi/pylint"
SRC_URI="ftp://ftp.logilab.org/pub/${PN}/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc examples test"

# Versions specified in __pkginfo__.py; 'logilab-common >= 0.53.0,' 'astroid >= 0.24.3'
# New addition of atroid to portage is 1.0.1, >=dev-python/astroid-0.24.3 making limited sense
RDEPEND=">=dev-python/logilab-common-0.53.0[${PYTHON_USEDEP}]
	>=dev-python/astroid-1.1.1[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( "${RDEPEND}" )"

PATCHES=( "${FILESDIR}"/${PN}-0.26.0-gtktest.patch )

# Usual. Requ'd for impl specific failures in test phase
DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all () {
	# selection of straight html triggers a trivial annoying bug, we skirt it
	use doc && emake -C doc singlehtml
	distutils-r1_python_prepare_all
}

python_test() {
	# Test suite appears not to work under Python 3.
	# https://bitbucket.org/logilab/pylint/issue/240/
	local msg="Test suite broken with ${EPYTHON}"
	if [[ "${EPYTHON}" == python3* ]]; then
		einfo "${msg}"
		return 0
	elif [[ "${EPYTHON}" == "pypy" ]]; then
		sed -e 's:test_functionality:_&:g' -i build/lib/pylint/testutils.py || die
		sed -e 's:test_exhaustivity:_&:' -i test/test_func.py || die
	fi

	sed -e 's:test_analyze_explicit_script:_&:' -i test/unittest_lint.py || die
	pytest || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	doman man/{pylint,pyreverse}.1
	use examples && local EXAMPLES=( examples/. )
	use doc && HTML_DOCS=( doc/_build/html/. )
	distutils-r1_python_install_all
}

pkg_postinst() {
	# Optional dependency on "tk" USE flag would break support for Jython.
	elog "pylint-gui script requires dev-lang/python with \"tk\" USE flag enabled."
}
