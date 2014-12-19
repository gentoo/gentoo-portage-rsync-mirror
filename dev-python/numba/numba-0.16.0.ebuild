# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numba/numba-0.16.0.ebuild,v 1.1 2014/12/19 03:33:53 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="NumPy aware dynamic Python compiler using LLVM"
HOMEPAGE="http://numba.pydata.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc examples"

RDEPEND="
	dev-python/llvmlite[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.6[${PYTHON_USEDEP}]
	dev-python/enum34[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}"

python_compile() {
	if ! python_is_python3; then
		local CFLAGS="${CFLAGS} -fno-strict-aliasing"
		export CFLAGS
	fi
	distutils-r1_python_compile
}

python_test() {
	cd "${BUILD_DIR}"/lib* || die
	${PYTHON} -c "import numba; numba.test()" || die
}

python_install_all() {
	# doc needs obsolete sphnxjp package
	use doc && dodoc docs/Numba.pdf
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
