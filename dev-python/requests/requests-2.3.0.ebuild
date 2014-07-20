# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/requests/requests-2.3.0.ebuild,v 1.6 2014/07/20 12:15:19 klausman Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="HTTP library for human beings"
HOMEPAGE="http://python-requests.org/ http://pypi.python.org/pypi/requests"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ~ia64 ~mips ~x86 ~amd64-linux ~x86-linux ~x64-macos"
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
		"${FILESDIR}"/${PN}-2.2.0-system-chardet.patch
	)

	# use system chardet
	rm -r requests/packages/chardet || die

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" test_requests.py || die "Tests fail with ${EPYTHON}"
}
