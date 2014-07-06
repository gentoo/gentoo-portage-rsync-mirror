# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/polygon/polygon-3.0.6.ebuild,v 1.2 2014/07/06 13:18:13 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python3_{2,3,4} )

inherit distutils-r1

DESCRIPTION="Python package to handle polygonal shapes in 2D"
HOMEPAGE="http://www.j-raedler.de/projects/polygon"
SRC_URI="https://www.bitbucket.org/jraedler/${PN}3/downloads/Polygon3-${PV}.zip"

LICENSE="LGPL-2"
SLOT="3"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="app-arch/unzip"

S=${WORKDIR}/Polygon3-${PV}

DOCS=( HISTORY doc/Polygon.txt )

src_test() {
	python_test() {
		PYTHONPATH="${BUILD_DIR}/lib" ${EPYTHON} test/Test.py || die
	}
	python_foreach_impl python_test
}
