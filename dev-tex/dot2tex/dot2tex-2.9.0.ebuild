# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/dot2tex/dot2tex-2.9.0.ebuild,v 1.2 2014/12/04 10:46:06 aballier Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A Graphviz to LaTeX converter"
HOMEPAGE="https://dot2tex.readthedocs.org/ https://github.com/kjellmf/dot2tex"
SRC_URI="https://github.com/kjellmf/dot2tex/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE="doc examples"

DEPEND="dev-python/pyparsing[${PYTHON_USEDEP}]"
RDEPEND="
	media-gfx/pydot[${PYTHON_USEDEP}]
	media-gfx/graphviz"
DEPEND="${DEPEND}
	doc? ( dev-python/sphinx )"

python_compile_all() {
	if use doc ; then
		cd "${S}/docs"
		emake html
	fi
}

python_install_all() {
	distutils-r1_python_install_all

	if use doc; then
		dohtml -r docs/_build/html/*
	fi
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
