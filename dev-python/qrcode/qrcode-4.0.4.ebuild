# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qrcode/qrcode-4.0.4.ebuild,v 1.1 2014/04/13 11:44:44 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1

DESCRIPTION="QR Code generator on top of PIL"
HOMEPAGE="https://pypi.python.org/pypi/qrcode"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# optional deps:
# - dev-python/lxml for svg backend
# - virtual/pil for PIL backend
RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? (
		dev-python/lxml[${PYTHON_USEDEP}]
		virtual/python-unittest2[${PYTHON_USEDEP}] )"

python_test() {
	cd "${BUILD_DIR}"/lib || die

	local m=unittest
	[[ ${EPYTHON} == python2.6 ]] && m=unittest2.__main__
	set -- "${PYTHON}" -m ${m} qrcode.tests
	echo "$@" >&2
	"$@" || die "Tests failed with ${EPYTHON}"
}
