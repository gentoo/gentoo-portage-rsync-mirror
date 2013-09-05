# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/addons/addons-0.7.ebuild,v 1.2 2013/09/05 18:46:47 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_PN="AddOns"

DESCRIPTION="Dynamically extend other objects (formerly ObjectRoles)"
HOMEPAGE="http://pypi.python.org/pypi/AddOns/"
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
	"${PYTHON}" peak/util/addons.py && einfo "Tests passed under ${EPYTHON}" \
		|| die "Tests failed under ${EPYTHON}"
}
