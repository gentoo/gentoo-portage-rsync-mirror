# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chaco/chaco-4.0.0.ebuild,v 1.2 2012/02/27 02:55:06 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils virtualx

DESCRIPTION="Enthought Tool Suite: interactive plotting toolkit"
HOMEPAGE="http://code.enthought.com/projects/chaco/ http://pypi.python.org/pypi/chaco"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/enable-4.0
	dev-python/numpy"
DEPEND="dev-python/setuptools
	dev-python/numpy
	doc? (
		>=dev-python/enable-4.0
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		!prefix? ( x11-base/xorg-server[xvfb] )
		x11-apps/xhost
	)
	test? (
		>=dev-python/enable-4.0
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

DOCS="docs/*.txt"

src_compile() {
	distutils_src_compile
	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		doc_generation() {
			emake html || die "Generation of documentation failed"
		}
		VIRTUALX_COMMAND="doc_generation" virtualmake
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

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "Installation of examples failed"
	fi
}
