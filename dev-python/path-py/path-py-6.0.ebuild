# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/path-py/path-py-6.0.ebuild,v 1.1 2014/09/27 16:11:32 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A module wrapper for os.path"
HOMEPAGE="http://github.com/jaraco/path.py"
MY_P="path.py-${PV}"
SRC_URI="mirror://pypi/p/path.py/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

S="${WORKDIR}/${MY_P}"

python_test() {
	py.test || die "Testing failed with ${EPYTHON}"
}
