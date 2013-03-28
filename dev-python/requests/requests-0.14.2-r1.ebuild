# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/requests/requests-0.14.2-r1.ebuild,v 1.2 2013/03/28 10:18:18 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="HTTP library for human beings"
HOMEPAGE="http://python-requests.org/ http://pypi.python.org/pypi/requests"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

RDEPEND="app-misc/ca-certificates
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

# tests connect to various remote sites
RESTRICT="test"

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}"/${PN}-0.14.1-system-cacerts.patch
		"${FILESDIR}"/${PN}-0.14.1-system-libs.patch
	)

	# use system libs for chardet, oauthlib, and urllib3
	rm -r requests/packages requests/cacert.pem || die

	# Different packages are installed depending on the python version.
	# Need to remove stale egg-info data and build in separate directories.
	rm -r requests.egg-info || die

	# lolwut? they explicitly cause 'install' to fail...
	sed -i -e '/DONTWRITEBYTECODE/d' setup.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
