# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mpmath/mpmath-0.17-r1.ebuild,v 1.5 2014/02/02 17:14:58 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1 eutils # virtualx

MY_PN=${PN}-all
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python library for arbitrary-precision floating-point arithmetic"
HOMEPAGE="http://code.google.com/p/mpmath/ http://pypi.python.org/pypi/mpmath/"
SRC_URI="http://mpmath.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-linux ~ppc-macos"
IUSE="doc examples gmp matplotlib test"

RDEPEND="
	gmp? ( dev-python/gmpy )
	matplotlib? ( dev-python/matplotlib )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}/${PN}.patch"
		"${FILESDIR}/${P}-python-3.2.patch"
		"${FILESDIR}/${P}-gmpy2.patch"
		)

	# this fails with the current version of dev-python/py
	rm -f ${PN}/conftest.py || die

	# this test requires X
	rm -f ${PN}/tests/test_visualization.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		einfo "Generation of documentation"
		cd doc || die
		"${PYTHON}" build.py || die "Generation of documentation failed"
	fi
}

#src_test() {
#	local DISTUTILS_NO_PARALLEL_BUILD=true
#	VIRTUALX_COMMAND="distutils-r1_src_test"
#	virtualmake
#}

python_test() {
	py.test -v || die
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/. )

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo/*
	fi
	distutils-r1_python_install_all
}

python_install() {
	distutils-r1_python_install
	local path="${ED}$(python_get_sitedir)/${PN}/libmp/"
	if [[ "${EPYTHON}" != python2* ]]; then
		rm -f "${path}exec_py2.py" || ide
	elif [[ "${EPYTHON}" != python3 ]]; then
		rm -f "${path}exec_py3.py" || die
	fi
}
