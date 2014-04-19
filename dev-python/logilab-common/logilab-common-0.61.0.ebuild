# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-common/logilab-common-0.61.0.ebuild,v 1.6 2014/04/19 18:11:20 mgorny Exp $

EAPI=5

# 0.60.0 fails unittest_umessage with python3.3
# http://www.logilab.org/ticket/149345
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1 eutils

DESCRIPTION="Useful miscellaneous modules used by Logilab projects"
HOMEPAGE="http://www.logilab.org/project/logilab-common http://pypi.python.org/pypi/logilab-common"
SRC_URI="ftp://ftp.logilab.org/pub/common/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ~ppc64 ~s390 ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="test doc"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	virtual/python-unittest2[${PYTHON_USEDEP}]"

# Tests using dev-python/psycopg are skipped when dev-python/psycopg
# isn't installed.
# egenix-mx-base tests are optional, and egenix-mx-base does support
# Python2 only.
DEPEND="${RDEPEND}
	test? (
		$(python_gen_cond_dep 'dev-python/egenix-mx-base[${PYTHON_USEDEP}]' 'python2*')
		!dev-python/psycopg[-mxdatetime]
	)
	doc? ( dev-python/epydoc )"

PATCHES=(
	# Make sure setuptools does not create a zip file in python_test;
	# this is buggy and causes tests to fail.
	"${FILESDIR}/${PN}-0.59.1-zipsafe.patch"

	# Depends on order of dictionary keys
	"${FILESDIR}/logilab-common-0.60.0-skip-doctest.patch"
)

python_prepare_all() {
	sed -e 's:(CURDIR):{S}/${P}:' -i doc/makefile || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		# Simplest way to make makefile point to the right place.
		ln -s "${BUILD_DIR}" build || die
		emake -C doc epydoc
		rm build || die
	fi
}

python_test() {
	distutils_install_for_testing

	# https://www.logilab.org/ticket/149345
	# Prevent timezone related failure.
	export TZ=UTC

	# Make sure that the tests use correct modules.
	pushd "${TEST_DIR}"/lib > /dev/null || die
	#  Returns a clean run under py3.3
	if [[ "${EPYTHON}" == 'python3.3' ]]; then
		rm $(find . -name unittest_umessage.py) || die
	fi
	"${TEST_DIR}"/scripts/pytest || die "Tests fail with ${EPYTHON}"
	popd > /dev/null || die
}

python_install_all() {
	distutils-r1_python_install_all

	doman doc/pytest.1
	use doc &&  dohtml -r doc/apidoc/.
}
