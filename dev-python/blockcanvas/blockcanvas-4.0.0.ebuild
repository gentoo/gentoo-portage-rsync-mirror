# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blockcanvas/blockcanvas-4.0.0.ebuild,v 1.2 2012/08/07 04:04:48 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils virtualx

DESCRIPTION="Enthought Tool Suite: Numerical modeling"
HOMEPAGE="http://code.enthought.com/projects/block_canvas/ http://pypi.python.org/pypi/blockcanvas"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-python/apptools-4.0
	>=dev-python/chaco-4.0
	>=dev-python/codetools-4.0
	>=dev-python/etsdevtools-4.0
	>=dev-python/pyface-4.0
	>=dev-python/scimath-4.0
	>=dev-python/traitsui-4.0
	dev-python/configobj
	dev-python/docutils
	dev-python/greenlet
	dev-python/imaging
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
	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_test() {
	VIRTUALX_COMMAND="distutils_src_test" virtualmake
}

src_install() {
	find -name "*LICENSE*.txt" -delete
	distutils_src_install

	if use doc; then
		pushd docs/build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _images _static || die "Installation of documentation failed"
		popd > /dev/null
	fi
}
