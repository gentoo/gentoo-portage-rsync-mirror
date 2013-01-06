# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hcs-utils/hcs-utils-1.3.ebuild,v 1.1 2012/12/25 04:41:56 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A library containing some useful snippets"
HOMEPAGE="http://pypi.python.org/pypi/hcs_utils"
SRC_URI="mirror://pypi/h/${PN/-/_}/${P/-/_}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND=""

S="${WORKDIR}/${P/-/_}"

python_test() {
	cd "${BUILD_DIR}/lib" || die
	py.test --doctest-modules hcs_utils || die
}
