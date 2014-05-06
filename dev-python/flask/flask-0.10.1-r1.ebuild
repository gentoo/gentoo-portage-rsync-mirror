# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask/flask-0.10.1-r1.ebuild,v 1.5 2014/05/06 05:25:21 idella4 Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3} pypy )

inherit distutils-r1

DESCRIPTION="A microframework based on Werkzeug, Jinja2 and good intentions"
MY_PN="Flask"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"
HOMEPAGE="http://pypi.python.org/pypi/Flask"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples test"

RDEPEND="dev-python/blinker[${PYTHON_USEDEP}]
	>=dev-python/itsdangerous-0.21[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.4[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/werkzeug-0.7[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
# Usual; test phase
DISTUTILS_IN_SOURCE_BUILD=1

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}"/${P}-is_package.patch )

python_prepare_all() {
	# https://github.com/mitsuhiko/flask/issues/837
	sed -e s':test_uninstalled_package_paths:_&:' \
		-i flask/testsuite/config.py || die
	sed -e s':test_json_key_sorting:_&:' \
		-i flask/testsuite/helpers.py || die
	sed -e s':test_appcontext_signals:_&:' \
		-i flask/testsuite/signals.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	# https://github.com/mitsuhiko/flask/issues/837, 1047
	if [[ "${EPYTHON}" == pypy ]]; then
		sed -e s':test_build_error_handler:_&:' \
			-i flask/testsuite/basic.py || die
		sed -e s':test_session_transactions_no_null_sessions:_&:' \
			-i flask/testsuite/testing.py || die
	fi
	"${PYTHON}" run-tests.py || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
