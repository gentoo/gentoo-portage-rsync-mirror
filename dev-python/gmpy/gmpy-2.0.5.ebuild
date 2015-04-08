# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gmpy/gmpy-2.0.5.ebuild,v 1.2 2015/01/21 03:37:27 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

MY_PN="${PN}2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python bindings for GMP, MPC, MPFR and MPIR libraries"
HOMEPAGE="http://code.google.com/p/gmpy/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc mpir"

RDEPEND="
	>=dev-libs/mpc-1.0.2
	>=dev-libs/mpfr-3.1.2
	!mpir? ( dev-libs/gmp )
	mpir? ( sci-libs/mpir )"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

S="${WORKDIR}"/${MY_P}

python_prepare_all() {
	# rm non std test file
	rm test*/gmpy_test_thr.py || die
	distutils-r1_python_prepare_all
}

python_configure_all() {
	mydistutilsargs=(
		$(usex mpir --mpir --gmp)
		)
}

python_compile() {
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
	distutils-r1_python_compile
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	cd test || die
	"${PYTHON}" runtests.py || die "tests failed under ${EPYTHON}"
	if python_is_python3; then
		cd ../test3 || die
	else
		cd ../test2 || die
	fi
	"${PYTHON}" gmpy_test.py || die "tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
