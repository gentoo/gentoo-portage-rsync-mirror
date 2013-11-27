# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wsgiintercept/wsgiintercept-0.6.0.ebuild,v 1.1 2013/11/27 16:13:23 dev-zero Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1

MY_PN="wsgi_intercept"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="WSGI application in place of a real URI for testing"
HOMEPAGE="https://pypi.python.org/pypi/wsgi_intercept https://github.com/cdent/python3-wsgi-intercept"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/pytest-2.4[${PYTHON_USEDEP}]
		>=dev-python/requests-2[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${PV}-fix-tests.patch" )

python_test() {
	py.test || die
}
