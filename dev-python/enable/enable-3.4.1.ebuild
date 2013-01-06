# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enable/enable-3.4.1.ebuild,v 1.2 2012/02/24 09:37:06 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils virtualx

MY_PN="Enable"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite: Drawing and interaction packages"
HOMEPAGE="http://code.enthought.com/projects/enable/ http://pypi.python.org/pypi/Enable"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/enthoughtbase-3.1.0
	dev-python/numpy
	dev-python/reportlab
	dev-python/setuptools
	>=dev-python/traitsgui-3.6.0[wxwidgets]
	>=media-libs/freetype-2
	virtual/opengl
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-lang/swig
	dev-python/cython
	doc? ( dev-python/sphinx )
	test? (
		dev-python/coverage
		dev-python/nose
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		x11-apps/xhost
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="docs/*.txt"
PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${PN}-3.3.0-nofreetype.patch"
}

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
	find -name "*LICENSE.txt" -delete
	distutils_src_install

	if use doc; then
		pushd docs/build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "Installation of examples failed"
	fi
}
