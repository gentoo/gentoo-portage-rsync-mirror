# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsui/traitsui-4.3.0-r1.ebuild,v 1.2 2013/04/12 05:51:09 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 virtualx

DESCRIPTION="Enthought Tool Suite: Traits-capable user interfaces"
HOMEPAGE="https://github.com/enthought/traitsui http://pypi.python.org/pypi/traitsui"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND="dev-python/pyface[${PYTHON_USEDEP}]
	dev-python/traits[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? (
		${RDEPEND}
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

DOCS=( docs/traitsuidocreadme.txt )

PATCHES=( "${FILESDIR}"/${P}-tests.patch )

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	export ETS_TOOLKIT=qt4
	export QT_API=pyqt
	VIRTUALX_COMMAND="nosetests -v" virtualmake

}

python_install_all() {
	distutils-r1_python_install_all
	find -name "*LICENSE*.txt" -delete
	use doc && dohtml -r docs/build/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
