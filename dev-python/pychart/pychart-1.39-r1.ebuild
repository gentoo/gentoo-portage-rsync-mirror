# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychart/pychart-1.39-r1.ebuild,v 1.4 2014/03/31 21:02:53 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

MY_P=PyChart-${PV}

DESCRIPTION="Python library for creating charts"
HOMEPAGE="http://home.gna.org/pychart/"
SRC_URI="http://download.gna.org/pychart/${MY_P}.tar.gz
	doc? ( http://download.gna.org/pychart/${PN}-doc.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc x86"
IUSE="doc examples"

DEPEND="app-text/ghostscript-gpl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

python_install_all() {
	use doc && local HTML_DOCS=( "${WORKDIR}"/${PN}/. )
	use examples && local EXAMPLES=( demos/. )

	distutils-r1_python_install_all
}
