# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask/flask-0.10.1-r1.ebuild,v 1.3 2014/02/11 17:22:34 bicatali Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

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

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}"/${P}-is_package.patch )

python_test() {
	# https://github.com/mitsuhiko/flask/issues/837
	"${PYTHON}" run-tests.py || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
