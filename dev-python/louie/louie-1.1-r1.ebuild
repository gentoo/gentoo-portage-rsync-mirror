# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/louie/louie-1.1-r1.ebuild,v 1.1 2014/12/31 02:41:18 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SRC_TEST="nosetests"

inherit distutils-r1

MY_PN="Louie"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Signal dispatching mechanism for Python"
HOMEPAGE="http://pypi.python.org/pypi/Louie"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed -e "/'nose >= 0.8.3'/d" -i setup.py || die "sed failed"
	distutils-r1_python_prepare_all
}

python_test() {
	nosetests || die "Tests failed"
}
