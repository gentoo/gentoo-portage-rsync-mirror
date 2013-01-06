# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/pyephem/pyephem-3.7.5.1.ebuild,v 1.4 2012/11/19 07:38:41 xarthisius Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="Astronomical routines for the python programming language"
HOMEPAGE="http://rhodesmill.org/pyephem/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx )
	test? ( || ( dev-lang/python:2.7 dev-python/unittest2 ) )"
RDEPEND=""

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	# don't install rst files
	sed -i -e "s:'doc/\*\.rst',::" setup.py || die
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile
	if use doc; then
		PYTHONPATH=. emake -C src/ephem/doc html
	fi
}

src_test() {
	testing() {
		if [[ ${PYTHON_ABI} == "2.7" ]]; then
			PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)" \
   			"$(PYTHON)" -m unittest discover -s src/ephem
		else
			PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)" \
				unit2-${PYTHON_ABI} discover -s src/ephem
		fi
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r src/ephem/doc/_build/html/*

	delete_tests() {
		rm -rf "${ED}$(python_get_sitedir)/ephem/tests"
	}
	python_execute_function -q delete_tests
}
