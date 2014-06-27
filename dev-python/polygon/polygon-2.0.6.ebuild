# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/polygon/polygon-2.0.6.ebuild,v 1.1 2014/06/27 14:30:04 jer Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python package to handle polygonal shapes in 2D"
HOMEPAGE="http://www.j-raedler.de/projects/polygon/"
SRC_URI="mirror://bitbucket/jraedler/${PN}2/downloads/Polygon2-${PV}.zip"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="app-arch/unzip"

S=${WORKDIR}/Polygon2-${PV}

DOCS=( HISTORY doc/Polygon.txt )

src_test() {
	python_test() {
		PYTHONPATH="${BUILD_DIR}/lib" ${EPYTHON} test/Test.py || die
	}
	python_foreach_impl python_test
}
