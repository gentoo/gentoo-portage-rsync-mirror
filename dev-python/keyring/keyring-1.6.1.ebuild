# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/keyring/keyring-1.6.1.ebuild,v 1.2 2014/07/06 12:42:45 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} python{3_2,3_3} )

inherit distutils-r1
DESCRIPTION="Provides access to the system keyring service"
HOMEPAGE="https://bitbucket.org/kang/python-keyring-lib"
SRC_URI="mirror://pypi/k/${PN}/${P}.zip"

LICENSE="PSF-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		app-arch/unzip
	test? ( dev-python/pytest-runner[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pycrypto[${PYTHON_USEDEP}] )"
RDEPEND=""

python_prepare_all() {
	sed -e s':from .py30compat:from keyring.tests.py30compat:' -i keyring/tests/test_util.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	# test_backend.py and test_core.py access keyring backends
	# which may spawn password prompts and do other damage.

	# XXX: leave out the harmless tests (dummy backends?)
	for t in test_{cli,util}.py; do
		py.test "${BUILD_DIR}"/lib/${PN}/tests/${t} \
			|| die "${t} fails with ${EPYTHON}"
	done
}
