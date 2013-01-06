# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enable/enable-4.2.0.ebuild,v 1.4 2012/12/06 17:31:54 bicatali Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
PYTHON_TESTS_RESTRICTED_ABIS="2.6"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils virtualx

DESCRIPTION="Enthought Tool Suite: Drawing and interaction packages"
HOMEPAGE="http://code.enthought.com/projects/enable/ http://pypi.python.org/pypi/enable"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz
	http://dev.gentoo.org/~idella4/${PN}-4-TestsPaths.patch"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND="dev-python/numpy
	dev-python/reportlab
	>=dev-python/traitsui-4
	>=media-libs/freetype-2
	virtual/opengl
	x11-libs/libX11"
DEPEND="dev-python/setuptools
	dev-lang/swig
	dev-python/cython
	doc? ( dev-python/sphinx )
	test? (
		${RDEPEND}
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

DOCS="docs/*.txt"

src_prepare() {
	distutils_src_prepare

	# Remove check for Darwin systems, set py.test style xfails,
	# Re-set import paths in tests, 'enabling' enable to find its own in source modules!!?!
	epatch "${DISTDIR}"/${PN}-4-TestsPaths.patch \
		"${FILESDIR}"/${PN}-4-rogue-tests.patch
}

src_compile() {
	distutils_src_compile
	use doc && emake -C docs html
}

src_test() {
	# Hardcoding build-2.7, 2.7 being the only fully capable candidate
	VIRTUALX_COMMAND="python_execute_nosetests -P $(ls -d build-2.7/lib.linux-*/):." virtualmake
}

src_install() {
	find -name "*LICENSE*.txt" -delete
	distutils_src_install

	use doc && dohtml -r docs/build/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
