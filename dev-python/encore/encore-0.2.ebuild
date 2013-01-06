# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/encore/encore-0.2.ebuild,v 1.1 2012/12/06 18:24:08 bicatali Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
PYTHON_TESTS_RESTRICTED_ABIS="2.6"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Enthought Tool Suite: collection of core-level utility modules"
HOMEPAGE="https://github.com/enthought/encore"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND=""
DEPEND="doc? ( dev-python/sphinx )"

DOCS="dataflow.txt"

src_compile() {
	distutils_src_compile
	use doc && PYTHONPATH="$(ls -1d ${S}/build*/lib | head -n1)" \
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
