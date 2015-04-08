# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/linecache2/linecache2-1.0.0.ebuild,v 1.3 2015/03/30 16:16:06 jer Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

inherit distutils-r1

DESCRIPTION="Backports of the linecache module"
HOMEPAGE="https://github.com/testing-cabal/linecache2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa"
IUSE="test"

DEPEND="
	dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/fixtures[${PYTHON_USEDEP}]
		dev-python/unittest2[${PYTHON_USEDEP}]
	)
"
RDEPEND=""

python_test() {
	"${PYTHON}" -m unittest2 discover || die "tests failed under ${EPYTHON}"
}
