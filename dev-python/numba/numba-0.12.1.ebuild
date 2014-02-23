# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numba/numba-0.12.1.ebuild,v 1.1 2014/02/23 00:06:35 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="NumPy aware dynamic Python compiler using LLVM"
HOMEPAGE="http://numba.pydata.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

IUSE="examples"

RDEPEND="
	dev-python/llvmpy[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.6[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_test() {
	cd "${BUILD_DIR}"/lib* || die
	${PYTHON} -c "import numba; numba.test()" || die
}

python_install_all() {
	# doc needs obsolete sphnxjp package
	#use doc && local HTML_DOCS=( docs/_build/html )
	use examples && local EXAMPLES=( examples )
	distutils-r1_python_install_all
}
