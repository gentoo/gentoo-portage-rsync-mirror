# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testscenarios/testscenarios-0.4.ebuild,v 1.5 2014/08/20 20:26:22 blueness Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2} )

inherit distutils-r1

DESCRIPTION="Testscenarios, a pyunit extension for dependency injection"
HOMEPAGE="https://launchpad.net/testscenarios"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/nose[${PYTHON_USEDEP}]
				dev-python/testtools[${PYTHON_USEDEP}]
				dev-python/testresources[${PYTHON_USEDEP}] )"
RDEPEND=""

python_test() {
	# https://bugs.launchpad.net/testscenarios/+bug/1260573
	nosetests || die "Tests failed under ${EPYTHON}"
}
