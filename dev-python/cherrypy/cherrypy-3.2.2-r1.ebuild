# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrypy/cherrypy-3.2.2-r1.ebuild,v 1.10 2014/03/31 20:48:31 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2} pypy pypy2_0 )

inherit distutils-r1

MY_P="CherryPy-${PV}"

DESCRIPTION="CherryPy is a pythonic, object-oriented HTTP framework"
HOMEPAGE="http://www.cherrypy.org/ http://pypi.python.org/pypi/CherryPy"
SRC_URI="http://download.cherrypy.org/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ia64 ppc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND=""
S="${WORKDIR}/${MY_P}"
# Both req'd for test phase
DISTUTILS_IN_SOURCE_BUILD=1
DISTUTILS_NO_PARALLEL_BUILD=1

python_prepare_all() {
	sed -e 's:test_file_stream:_&:' -i cherrypy/test/test_static.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	# https://bitbucket.org/cherrypy/cherrypy/issue/1308/testsuite-failures-x-5-test_file_stream
	if python_is_python3; then
		sed -e 's:test_HTTP11_pipelining:_&:' -i cherrypy/test/test_conn.py || die
	elif [[ "${EPYTHON}" == "pypy-c2.0" || "${EPYTHON}" == "pypy-c" ]]; then
		einfo "done"
		sed -e 's:testEscapedOutput:_&:' \
			-e 's:testNormalReturn:_&:' \
			-e 's:testTracebacks:_&:' \
			-e 's:testNormalYield:_&:' \
			-i cherrypy/test/test_logging.py || die
	fi
	# This really doesn't sit well with multiprocessing
	nosetests < /dev/tty || die "Testing failed with ${EPYTHON}"
}
