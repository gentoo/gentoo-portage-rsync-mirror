# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lp_solve/lp_solve-5.5.2.0.ebuild,v 1.3 2012/07/09 17:20:49 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.4 3* 2.7-pypy-* *-jython"

inherit distutils eutils

DESCRIPTION="Python wrappers for lpsolve"
HOMEPAGE="http://lpsolve.sourceforge.net/5.5/Python.htm"
SRC_URI="mirror://sourceforge/lpsolve/${PN}_${PV}_Python_source.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND="dev-python/numpy
	sci-mathematics/lpsolve"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${PN}_5.5/extra/Python/"

src_prepare(){
	epatch "${FILESDIR}"/${P}-setup.patch
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" \
		"$(PYTHON)" lpdemo.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dodoc changes
	use doc && dohtml Python.htm
	insinto /usr/share/doc/${PF}/examples
	use examples && doins ex*py
}
