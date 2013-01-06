# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apptools/apptools-4.0.0.ebuild,v 1.4 2012/03/05 10:49:04 jlec Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils virtualx

DESCRIPTION="Enthought Tool Suite: application tools"
HOMEPAGE="http://code.enthought.com/projects/app_tools/ http://pypi.python.org/pypi/apptools"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/configobj
	dev-python/numpy
	>=dev-python/traits-4.1.0"
DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? (
		${RDEPEND}
		dev-python/pyface
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

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

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
