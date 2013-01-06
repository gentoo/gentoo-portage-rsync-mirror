# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enaml/enaml-0.2.0.ebuild,v 1.1 2012/12/06 21:42:03 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3* *-jython 2.7-pypy-*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="Enthought Tool Suite: framework for writing declarative interfaces"
HOMEPAGE="http://code.enthought.com/projects/enaml/ http://pypi.python.org/pypi/enaml"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND="
	dev-python/casuarius
	dev-python/ply
	dev-python/traits
	|| ( dev-python/wxpython dev-python/PyQt4 dev-python/pyside )"

DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

src_prepare() {
	# crash doc and gone upstream (> 0.2.0)
	sed -i -e '/enthought.debug.api/d' enamldoc/sphinx_ext.py || die
}

src_compile() {
	distutils_src_compile
	use doc && PYTHONPATH="$(ls -1d ${S}/build*/lib* | head -n1)" \
		emake -C docs html
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
