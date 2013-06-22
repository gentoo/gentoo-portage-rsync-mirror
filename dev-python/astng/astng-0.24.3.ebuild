# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/astng/astng-0.24.3.ebuild,v 1.2 2013/06/22 10:04:24 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Abstract Syntax Tree for logilab packages"
HOMEPAGE="http://www.logilab.org/project/logilab-astng http://pypi.python.org/pypi/logilab-astng"
SRC_URI="ftp://ftp.logilab.org/pub/astng/logilab-${P}.tar.gz mirror://pypi/l/logilab-astng/logilab-${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos ~x86-macos"
IUSE="test"

# Version specified in __pkginfo__.py.
RDEPEND=">=dev-python/logilab-common-0.59.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/egenix-mx-base-3.0.0[$(python_gen_usedep 'python2*')] )"

S="${WORKDIR}/logilab-${P}"

# a wit; pypy reports astng modules differently
PATCHES=( "${FILESDIR}"/pypy-test.patch )

python_test() {
	distutils_install_for_testing
	#https://bitbucket.org/logilab/astroid/issue/1/test-suite-fails-in-0243-under-py32-pypy
	# Make sure that the tests use correct modules.
	cd "${TEST_DIR}"/lib || die
	unset PYTHONPATH
	if [[ "${EPYTHON}" == 'python3.3' ]]; then
		einfo "python3.3 has a problem with test suite"
	else
		 pytest || die "Tests fail with ${EPYTHON}"
	fi
}

python_install() {
	distutils-r1_python_install

	rm "${D}$(python_get_sitedir)/logilab/__init__.py" || die
}
