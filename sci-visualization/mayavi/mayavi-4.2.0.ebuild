# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-4.2.0.ebuild,v 1.2 2012/12/06 19:37:26 bicatali Exp $

EAPI=4

RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils virtualx

DESCRIPTION="Enthought Tool Suite: Scientific data 3-dimensional visualizer"
HOMEPAGE="
	http://code.enthought.com/projects/mayavi/
	http://pypi.python.org/pypi/mayavi/"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND="
	dev-python/apptools
	dev-python/configobj
	dev-python/envisage
	dev-python/ipython
	dev-python/numpy
	dev-python/pyface
	dev-python/traitsui
	dev-python/wxpython"
CDEPEND="sci-libs/vtk[python]"
DEPEND="
	${CDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? (
		${RDEPEND}
		dev-python/nose
		dev-python/wxpython[opengl]
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

DOCS="docs/*.txt"

# Its broken, run
# mayavi2 --test
# instead
RESTRICT="test"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-doc.patch
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile
	if use doc; then
		$(PYTHON) setup.py gen_docs || die
		$(PYTHON) setup.py build_docs || die
	fi
}

src_install() {
	find . -name "*LICENSE*.txt" -delete || die
	distutils_src_install

	use doc && dohtml -r docs/build/mayavi/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	newicon mayavi/core/ui/images/m2.png mayavi2.png
	make_desktop_entry ${PN}2 \
		"Mayavi2 2D/3D Scientific Visualization" ${PN}2
}
