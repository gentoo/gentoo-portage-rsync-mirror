# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-6.0.1.ebuild,v 1.2 2014/04/01 11:17:49 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit db-use distutils-r1 multilib

DESCRIPTION="Python bindings for Berkeley DB"
HOMEPAGE="http://www.jcea.es/programacion/pybsddb.htm http://pypi.python.org/pypi/bsddb3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

RDEPEND=">=sys-libs/db-4.8.30"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

# PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DISTUTILS_IN_SOURCE_BUILD=1
PATCHES=( "${FILESDIR}"/py3tests.patch )

src_configure() {
	local DB_VER
	if has_version sys-libs/db:5.1; then
		DB_VER="5.1"
	elif has_version sys-libs/db:5.0; then
		DB_VER="5.0"
	else
		DB_VER="4.8"
	fi
	sed -e "s/dblib = 'db'/dblib = '$(db_libname ${DB_VER})'/" -i setup2.py setup3.py || die "sed failed"
}

src_compile() {
	distutils-r1_src_compile \
		--berkeley-db="${EPREFIX}/usr" \
		--berkeley-db-incdir="${EPREFIX}$(db_includedir ${DB_VER})" \
		--berkeley-db-libdir="${EPREFIX}/usr/$(get_libdir)"
}

python_test() {
	# py3 tests misfire in the source om running test_all.py
	local test
	pushd "${BUILD_DIR}"/../ > /dev/null
	if [[ "${EPYTHON}" == python2* ]]; then
		einfo "all 500 tests are run silently and may take a number of minutes to complete"
		"${PYTHON}" build/lib/bsddb3/tests/test_all.py || die  "tests failed under ${EPYTHON}"
	elif python_is_python3; then
		mv Lib3/bsddb/test/test_all.py . || die
		for test in Lib3/bsddb/test/test_*
		do
			"${PYTHON}" $test || die "tet $test failed under ${EPYTHON}"
			einfo "test $test passed OK";einfo ""
		done
	fi
	popd  > /dev/null
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/html/. )
	distutils-r1_python_install_all
}
