# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-5.3.0-r1.ebuild,v 1.1 2013/05/28 19:00:19 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_2,3_3} )

inherit db-use distutils-r1 multilib

DESCRIPTION="Python bindings for Berkeley DB"
HOMEPAGE="http://www.jcea.es/programacion/pybsddb.htm http://pypi.python.org/pypi/bsddb3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND=">=sys-libs/db-4.8.30"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS=( ChangeLog TODO.txt )
DISTUTILS_IN_SOURCE_BUILD=1

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
	# https://sourceforge.net/p/pybsddb/bugs/72/
	pushd "${BUILD_DIR}"/../ > /dev/null
	if [[ "${EPYTHON}" == python2* ]]; then
		"${PYTHON}" build/lib/bsddb3/tests/test_all.py
	elif [[ "${EPYTHON}" == python3* ]]; then
		"${PYTHON}" setup.py build
		einfo "all 500 tests are run silently and may take a number of minutes to complete"
		"${PYTHON}" ./test3.py
	fi
}

python_install() {
	rm -fr "${ED}$(python_get_sitedir)/bsddb3/tests"

	if use doc; then
		dohtml -r docs/html/* || die "dohtml failed"
	fi
	distutils-r1_python_install
}

python_install_all() {
	local HTML_DOCS=( docs/html/. )
	distutils-r1_python_install_all
}
