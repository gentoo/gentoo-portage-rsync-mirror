# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dynd-python/dynd-python-0.6.0.ebuild,v 1.1 2014/02/11 03:02:58 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit cmake-utils python-r1

DESCRIPTION="Python exposure of multidimensionnal array library libdynd"
HOMEPAGE="https://github.com/ContinuumIO/dynd-python"
SRC_URI="https://github.com/ContinuumIO/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

IUSE="doc test"

RDEPEND="
	~dev-libs/libdynd-${PV}
	>=dev-python/numpy-1.5[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	>=dev-python/cython-0.19[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"

PATCHES=( "${FILESDIR}"/${P}-out-of-git-versioning.patch )

src_configure() {
	local mycmakeargs=(
		-Wno-dev
		-DUSE_SEPARATE_LIBDYND=ON
		$(cmake-utils_use test DYND_BUILD_TESTS)
	)
	python_foreach_impl cmake-utils_src_configure
}

src_compile() {
	python_foreach_impl cmake-utils_src_make
	use doc && emake -C doc html
}

src_test() {
	testing() {
		cmake-utils_src_make DESTDIR="${WORKDIR}-test-${EPYTHON}" install
		cd "${WORKDIR}-test-${EPYTHON}"/$(python_get_sitedir) || die
		${PYTHON} -c 'import dynd; dynd.test()' || die
	}
	python_foreach_impl testing
}

src_install() {
	python_foreach_impl cmake-utils_src_install
	dodoc README.md
	use doc && dohtml -r doc/build/html/*
}
