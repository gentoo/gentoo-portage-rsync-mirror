# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ply/ply-3.4.ebuild,v 1.8 2012/12/31 16:33:04 ago Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python Lex-Yacc library"
HOMEPAGE="http://www.dabeaz.com/ply/ http://pypi.python.org/pypi/ply"
SRC_URI="http://www.dabeaz.com/ply/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ~ia64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="examples"

DEPEND=""
RDEPEND=""

DOCS="ANNOUNCE CHANGES README TODO"

src_test() {
	python_enable_pyc

	cd test

	testing() {
		local exit_status="0" test

		for test in testlex.py testyacc.py; do
			einfo "Running ${test}..."
			if ! "$(PYTHON)" ${test}; then
				ewarn "${test} failed with $(python_get_implementation) $(python_get_version)"
				exit_status="1"
			fi
		done

		return "${exit_status}"
	}
	python_execute_function testing

	python_disable_pyc
}

src_install() {
	distutils_src_install

	dohtml doc/* || die "dohtml failed"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r example/* || die "doins failed"
	fi
}
