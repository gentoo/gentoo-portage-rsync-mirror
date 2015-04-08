# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/pymmlib/pymmlib-1.2.0-r1.ebuild,v 1.1 2013/12/02 11:03:55 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 multilib

DESCRIPTION="Toolkit and library for the analysis and manipulation of macromolecular structural models"
HOMEPAGE="http://pymmlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/pymmlib/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pygtkglext[${PYTHON_USEDEP}]
	media-libs/freeglut
	virtual/glu
	virtual/opengl
	x11-libs/libXmu"
DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc[${PYTHON_USEDEP}] )"

python_prepare_all() {
	rm mmLib/NumericCompat.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		${EPYTHON} setup.py doc || die
	fi
}

python_install_all() {
	DOCS=( "${S}"/README.txt )
	use doc && HTML_DOCS=( "${S}"/doc/. )
	distutils-r1_python_install_all

	python_foreach_impl python_doscript "${S}"/applications/* "${S}"/examples/*.py
}
