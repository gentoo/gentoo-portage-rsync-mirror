# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/networkx/networkx-1.7-r2.ebuild,v 1.1 2013/04/26 09:50:14 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python tools to manipulate graphs and complex networks"
HOMEPAGE="http://networkx.lanl.gov http://pypi.python.org/pypi/networkx"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~ppc-macos ~x86-linux ~x86-macos"
IUSE="doc examples test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/pygraphviz[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		sci-libs/scipy[${PYTHON_USEDEP}]
	)"
RDEPEND="
	examples? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/pygraphviz[${PYTHON_USEDEP}]
		virtual/pyparsing[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		sci-libs/scipy[${PYTHON_USEDEP}]
	 )"

python_compile_all() {
	if use doc; then
		elog "Building docs"
		# PYTHONPATH is necessary to use networkx to be installed.
		cd "${S}"/doc || die
		sed \
			-e "s:^\t\./:\t${PYTHON} :g" \
			-i Makefile || die
		pwd
		PYTHONPATH="${S}:${PYTHONPATH}" make html \
			|| die "doc compilation failed"
	fi
}

python_install_all() {
	distutils-r1_python_install_all

	rm -f "${ED}"usr/share/doc/${PF}/{INSTALL,LICENSE}.txt || die
	if ! use examples; then
		rm -r "${ED}"usr/share/doc/${P}/examples || die
	fi
	use doc && dohtml -r doc/build/html/*
}
