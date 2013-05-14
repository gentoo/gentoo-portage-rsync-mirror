# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enable/enable-4.3.0.ebuild,v 1.1 2013/05/14 13:57:21 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SRC_TEST="nosetests"

inherit distutils-r1 virtualx

DESCRIPTION="Enthought Tool Suite: Drawing and interaction packages"
HOMEPAGE="http://code.enthought.com/projects/enable/ http://pypi.python.org/pypi/enable"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz
	http://dev.gentoo.org/~idella4/${PN}-4-TestsPaths.patch"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"
DISTUTILS_IN_SOURCE_BUILD=1

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
	>=dev-python/traitsui-4[${PYTHON_USEDEP}]
	>=media-libs/freetype-2
	virtual/opengl
	virtual/glu
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-lang/swig
	dev-python/cython[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? (
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

# Remove check for Darwin systems, set py.test style xfails,
# Re-set import paths in tests, 'enabling' enable to find its own in source modules!!?!
# https://github.com/enthought/enable/issues/99
PATCHES=( "${FILESDIR}"/${PN}-4-rogue-tests.patch \
	   "${DISTDIR}"/${PN}-4-TestsPaths.patch )

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	VIRTUALX_COMMAND="nosetests" virtualmake
}

python_install_all() {
	use doc && dohtml -r docs/build/html/*

	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
