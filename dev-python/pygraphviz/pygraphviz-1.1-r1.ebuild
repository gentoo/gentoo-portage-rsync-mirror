# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygraphviz/pygraphviz-1.1-r1.ebuild,v 1.2 2011/08/05 18:05:31 bicatali Exp $

EAPI="3"
PYTHON_DEPEND=2
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Python wrapper for the Graphviz Agraph data structure"
HOMEPAGE="http://networkx.lanl.gov/pygraphviz/ http://pypi.python.org/pypi/pygraphviz"
SRC_URI="http://networkx.lanl.gov/download/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="examples"

RDEPEND=">=media-gfx/graphviz-2.12"
DEPEND="${RDEPEND}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/${PN}-1.0-setup.py.patch
	epatch "${FILESDIR}"/${P}-avoid_tests.patch
}

src_test() {
	testing() {
		"$(PYTHON)" -c "import sys; sys.path.insert(0, '$(ls -d build-${PYTHON_ABI}/lib.*)'); import pygraphviz.tests; pygraphviz.tests.run()"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Installation of examples failed"
	fi

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/${PN}/tests"
	}
	python_execute_function -q delete_tests
}
