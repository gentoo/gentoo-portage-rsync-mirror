# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blockcanvas/blockcanvas-4.0.3.ebuild,v 1.2 2013/06/09 17:01:23 floppym Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.5-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils virtualx

DESCRIPTION="Enthought Tool Suite: Numerical modeling"
HOMEPAGE="http://code.enthought.com/projects/block_canvas/ http://pypi.python.org/pypi/blockcanvas"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"
RESTRICT="test"

RDEPEND=">=dev-python/apptools-4
	>=dev-python/chaco-4
	>=dev-python/codetools-4
	>=dev-python/etsdevtools-4
	>=dev-python/pyface-4
	>=dev-python/scimath-4
	>=dev-python/traitsui-4
	dev-python/configobj
	dev-python/docutils
	dev-python/greenlet
	virtual/python-imaging
	dev-python/numpy"
DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? (
		${RDEPEND}
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

DOCS="docs/*.txt"

src_compile() {
	distutils_src_compile
	use doc && emake -C docs html
}

src_test() {
	VIRTUALX_COMMAND="distutils_src_test" virtualmake
}

src_install() {
	find -name "*LICENSE*.txt" -delete
	distutils_src_install

	use doc && dohtml -r docs/build/html/*
}
