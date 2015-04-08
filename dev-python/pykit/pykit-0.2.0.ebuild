# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pykit/pykit-0.2.0.ebuild,v 1.2 2014/09/02 03:26:36 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Backend compiler for high-level typed code"
HOMEPAGE="http://pykit.github.io/pykit/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	dev-python/llvmmath[${PYTHON_USEDEP}]
	dev-python/llvmpy[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.6[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
"
DEPEND="
	test? ( ${RDEPEND} dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	cd "${BUILD_DIR}"/lib* || die
	${PYTHON} -c "import sys, pykit; sys.exit(pykit.test())" || die
}
