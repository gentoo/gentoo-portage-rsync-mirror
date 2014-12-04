# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/polygon/polygon-3.0.7.ebuild,v 1.2 2014/12/04 09:58:01 ago Exp $

EAPI=5
PYTHON_COMPAT=( python3_{2,3,4} )

inherit distutils-r1

DESCRIPTION="Python package to handle polygonal shapes in 2D"
HOMEPAGE="http://www.j-raedler.de/projects/polygon"
SRC_URI="https://www.bitbucket.org/jraedler/${PN}3/downloads/Polygon3-${PV}.zip"

LICENSE="LGPL-2"
SLOT="3"
IUSE="examples"
KEYWORDS="amd64 ~ppc ~x86"

DEPEND="app-arch/unzip"

S=${WORKDIR}/Polygon3-${PV}

DOCS=( doc/{Polygon.txt,Polygon.pdf} )

python_prepare_all() {
	if use examples; then
		mkdir examples || die
		mv doc/{Examples.py,testpoly.gpf} examples || die
	fi
	distutils-r1_python_prepare_all
}

python_test() {
	${PYTHON} test/Test.py || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
