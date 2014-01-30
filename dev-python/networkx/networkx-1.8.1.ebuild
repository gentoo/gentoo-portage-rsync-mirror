# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/networkx/networkx-1.8.1.ebuild,v 1.4 2014/01/30 15:04:25 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1

DESCRIPTION="Python tools to manipulate graphs and complex networks"
HOMEPAGE="http://networkx.lanl.gov http://pypi.python.org/pypi/networkx"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc examples test"

PY2_USEDEP=$(python_gen_usedep 'python2*')

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/pygraphviz[${PY2_USEDEP}]
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
		dev-python/pygraphviz[${PY2_USEDEP}]
		dev-python/pyparsing[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		sci-libs/scipy[${PYTHON_USEDEP}]
	)"

python_compile_all() {
	if use doc; then
		sed \
			-e "s:^\t\./:\t${PYTHON} :g" \
			-i doc/Makefile || die
		emake -C doc html
	fi
}

python_test() {
	nosetests -vv || die
}

python_install_all() {
	# Oh my.
	rm -r "${ED}"usr/share/doc/${P} || die

	use doc && local HTML_DOCS=( doc/build/html/. )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
