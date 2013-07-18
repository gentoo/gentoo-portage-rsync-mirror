# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-5.3.0.ebuild,v 1.13 2013/07/17 23:24:15 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2 3:3.1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.0 *-jython 2.7-pypy-*"

inherit db-use distutils multilib

DESCRIPTION="Python bindings for Berkeley DB"
HOMEPAGE="http://www.jcea.es/programacion/pybsddb.htm http://pypi.python.org/pypi/bsddb3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ~ppc64 ~sparc x86"
IUSE="doc"

RDEPEND=">=sys-libs/db-4.8.30"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="ChangeLog TODO.txt"

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
	distutils_src_compile \
		--berkeley-db="${EPREFIX}/usr" \
		--berkeley-db-incdir="${EPREFIX}$(db_includedir ${DB_VER})" \
		--berkeley-db-libdir="${EPREFIX}/usr/$(get_libdir)"
}

src_test() {
	tests() {
		rm -f build
		ln -s build-${PYTHON_ABI} build

		echo TMPDIR="${T}/tests-${PYTHON_ABI}" "$(PYTHON)" test.py
		einfo "all 500 tests are run silently and may take a number of minutes to complete"
		TMPDIR="${T}/tests-${PYTHON_ABI}" "$(PYTHON)" test.py
	}
	python_execute_function tests
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/bsddb3/tests"
	}
	python_execute_function -q delete_tests

	if use doc; then
		dohtml -r docs/html/* || die "dohtml failed"
	fi
}
