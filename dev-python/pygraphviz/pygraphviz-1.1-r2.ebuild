# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygraphviz/pygraphviz-1.1-r2.ebuild,v 1.1 2013/04/26 08:40:49 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python wrapper for the Graphviz Agraph data structure"
HOMEPAGE="http://networkx.lanl.gov/pygraphviz/ http://pypi.python.org/pypi/pygraphviz"
SRC_URI="http://networkx.lanl.gov/download/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="examples"

RDEPEND="media-gfx/graphviz[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.0-setup.py.patch
	"${FILESDIR}"/${P}-avoid_tests.patch
)

python_test() {
	${PYTHON} \
		-c "import sys; sys.path.insert(0, \"${BUILD_DIR}/lib/pygraphviz\"); import pygraphviz.tests; pygraphviz.tests.run()" || die
}

python_install_all() {
	distutils-r1_python_install_all

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

python_install() {
	distutils-r1_python_install

	rm -fr "${ED}$(python_get_sitedir)/${PN}/tests"
}
