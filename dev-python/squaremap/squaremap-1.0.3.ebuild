# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/squaremap/squaremap-1.0.3.ebuild,v 1.2 2014/10/23 10:22:19 swegener Exp $

EAPI="5"

MY_PN="SquareMap"
MY_P="${MY_PN}-${PV/_beta/b}"

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Hierarchic data-visualisation control for wxPython"
HOMEPAGE="http://pypi.python.org/pypi/SquareMap"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	<dev-python/wxpython-3"

S="${WORKDIR}"/${MY_P}
