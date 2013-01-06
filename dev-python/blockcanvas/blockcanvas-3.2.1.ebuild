# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blockcanvas/blockcanvas-3.2.1.ebuild,v 1.3 2011/03/27 22:35:00 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils virtualx

MY_PN="BlockCanvas"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite: Numerical modeling"
HOMEPAGE="http://code.enthought.com/projects/block_canvas/ http://pypi.python.org/pypi/BlockCanvas"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-python/apptools-3.4.1
	>=dev-python/chaco-3.4.0
	dev-python/configobj
	dev-python/docutils
	>=dev-python/enthoughtbase-3.1.0
	>=dev-python/etsdevtools-3.1.1
	dev-python/greenlet
	dev-python/imaging
	dev-python/numpy
	>=dev-python/scimath-3.0.7
	dev-python/setuptools
	>=dev-python/traitsgui-3.6.0"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	test? (
		dev-python/nose
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		x11-apps/xhost
	)"

S="${WORKDIR}/${MY_P}"

DOCS="docs/*.txt"
PYTHON_MODNAME="enthought"

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
		doins -r [a-z]* _images _static || die "Installation of documentation failed"
		popd > /dev/null
	fi
}
