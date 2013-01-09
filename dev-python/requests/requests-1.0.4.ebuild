# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/requests/requests-1.0.4.ebuild,v 1.2 2013/01/09 02:13:30 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="HTTP library for human beings"
HOMEPAGE="http://python-requests.org/ http://pypi.python.org/pypi/requests"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="app-misc/ca-certificates
	dev-python/charade[${PYTHON_USEDEP}]
	dev-python/urllib3"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

# tests connect to various remote sites
RESTRICT="test"

PATCHES=( "${FILESDIR}"/${P}-system-libs.patch )

DOCS=( README.rst HISTORY.rst )

python_prepare_all() {
	# use system libs for charade and urllib3
	rm -r requests/packages || die

	# use system ca-certificates
	rm requests/cacert.pem || die

	distutils-r1_python_prepare_all
}

python_test() {
	nosetests || die
}
