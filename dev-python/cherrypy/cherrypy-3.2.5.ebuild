# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrypy/cherrypy-3.2.5.ebuild,v 1.2 2014/04/05 21:07:43 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2} pypy pypy2_0 )

inherit distutils-r1

MY_P="CherryPy-${PV}"

DESCRIPTION="CherryPy is a pythonic, object-oriented HTTP framework"
HOMEPAGE="http://www.cherrypy.org/ http://pypi.python.org/pypi/CherryPy"
SRC_URI="mirror://pypi/C/CherryPy/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND=""
S="${WORKDIR}/${MY_P}"

DISTUTILS_IN_SOURCE_BUILD=1

PATCHES=(
	"${FILESDIR}"/cherrypy-3.2.5-issue1234.patch
)

python_prepare_all() {
	# Prevent interactive failures (hangs) in the test suite
	sed -i -e "s/interactive = True/interactive = False/" cherrypy/test/webtest.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	# Failure in test_file_stream
	# https://bitbucket.org/cherrypy/cherrypy/issue/1308/testsuite-failures-x-5-test_file_stream

	# This really doesn't sit well with multiprocessing
	nosetests -e test_file_stream < /dev/tty || die "Testing failed with ${EPYTHON}"
}

src_test() {
	DISTUTILS_NO_PARALLEL_BUILD=1 distutils-r1_src_test
}
