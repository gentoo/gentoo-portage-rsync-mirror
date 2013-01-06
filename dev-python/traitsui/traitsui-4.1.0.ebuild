# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsui/traitsui-4.1.0.ebuild,v 1.2 2012/02/22 15:05:54 patrick Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils virtualx

DESCRIPTION="Enthought Tool Suite: Traits-capable user interfaces"
HOMEPAGE="https://github.com/enthought/traitsui http://pypi.python.org/pypi/traitsui"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/pyface
	dev-python/traits"
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

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
