# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/requests/requests-2.2.0.ebuild,v 1.1 2014/01/23 02:27:23 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="HTTP library for human beings"
HOMEPAGE="http://python-requests.org/ http://pypi.python.org/pypi/requests"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~x86"
IUSE=""

# bundles dev-python/urllib3 snapshot
RDEPEND="app-misc/ca-certificates
	>=dev-python/chardet-2.2.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

# tests connect to various remote sites
RESTRICT="test"

DOCS=( README.rst HISTORY.rst )

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}"/${PN}-1.2.0-system-cacerts.patch
		"${FILESDIR}"/${P}-system-chardet.patch
	)

	# use system chardet
	rm -r requests/packages/chardet || die

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" test_requests.py || die "Tests fail with ${EPYTHON}"
}
