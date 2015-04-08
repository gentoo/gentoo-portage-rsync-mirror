# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/astroid/astroid-1.0.1.ebuild,v 1.2 2014/03/31 21:01:07 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Abstract Syntax Tree for logilab packages"
HOMEPAGE="http://bitbucket.org/logilab/astroid http://pypi.python.org/pypi/astroid"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos ~x86-macos"
IUSE="test"

# Version specified in __pkginfo__.py.
RDEPEND=">=dev-python/logilab-common-0.60.0[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND} )"
# Required for tests
DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all() {
	# https://bitbucket.org/logilab/astroid/issue/8/
	sed -e "s/test_numpy_crash/_&/" -i test/unittest_regrtest.py

	distutils-r1_python_prepare_all
}

python_test() {
	# https://bitbucket.org/logilab/astroid/issue/1/test-suite-fails-in-0243-under-py32-pypy
	# https://bitbucket.org/logilab/astroid/issue/16/1-test-fail-test_socket_build-under-pypy
	# test_hashlib fails only in py3.2
	python setup.py build

	pushd build/lib > /dev/null
	if [[ "${EPYTHON}" == pypy* ]]; then
		sed -e 's:test_socket_build:_&:' -i ${PN}/test/unittest_builder.py || die
	elif [[ "${EPYTHON}" == 'python3.2' ]]; then
		sed -e 's:test_hashlib:_&:' -i ${PN}/test/unittest_brain.py || die
	fi
	PYTHONPATH=. pytest || die "Tests fail with ${EPYTHON}"
	popd > /dev/null
}
