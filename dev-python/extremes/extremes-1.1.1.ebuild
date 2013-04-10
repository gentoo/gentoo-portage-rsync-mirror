# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/extremes/extremes-1.1.1.ebuild,v 1.1 2013/04/10 04:28:06 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

MY_PN="Extremes"
DESCRIPTION="Production-quality 'Min' and 'Max' objects"
HOMEPAGE="http://pypi.python.org/pypi/Extremes"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.zip -> ${P}.zip"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="ZPL"
SLOT="0"

RDEPEND=""
DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${MY_PN}-${PV}

python_test() {
	"${PYTHON}" peak/util/extremes.py && einfo "Tests passed under ${EPYTHON}" \
		|| die "Tests failed under ${EPYTHON}"
}
