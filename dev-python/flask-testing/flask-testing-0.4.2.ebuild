# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-testing/flask-testing-0.4.2.ebuild,v 1.2 2015/01/16 03:47:13 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

MY_PN="Flask-Testing"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Unit testing for Flask"
HOMEPAGE="http://pythonhosted.org/Flask-Testing/ https://pypi.python.org/pypi/Flask-Testing/"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"
# Testsuite fails with concurrent threads
DISTUTILS_NO_PARALLEL_BUILD=1

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]
	dev-python/twill[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/blinker[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}/${MY_P}"

python_test() {
	# https://github.com/jarus/flask-testing/issues/60
	nosetests || die "Testing failed with ${EPYTHON}"
}
