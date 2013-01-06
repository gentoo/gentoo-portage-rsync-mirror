# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnuplot-py/gnuplot-py-1.8.ebuild,v 1.12 2012/02/23 09:15:51 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils eutils

DESCRIPTION="A python wrapper for Gnuplot"
HOMEPAGE="http://gnuplot-py.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 s390 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc"

DEPEND="dev-python/numpy"
RDEPEND="${DEPEND}
	sci-visualization/gnuplot"

DOCS="ANNOUNCE.txt CREDITS.txt FAQ.txt NEWS.txt TODO.txt"
PYTHON_MODNAME="Gnuplot"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-1.7-mousesupport.patch"
	python_convert_shebangs 2 demo.py test.py
}

src_install() {
	distutils_src_install

	delete_examples() {
		rm -f "${ED}$(python_get_sitedir)/Gnuplot/"{demo,test}.py
	}
	python_execute_function -q delete_examples

	insinto /usr/share/doc/${PF}/examples
	doins demo.py test.py

	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r doc/Gnuplot/* || die "doc install failed"
	fi
}
