# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/geopy/geopy-1.1.5.ebuild,v 1.1 2014/09/19 00:56:36 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A Geocoding Toolbox for Python"
HOMEPAGE="http://www.geopy.org/ https://github.com/geopy/geopy"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

IUSE="test yahoo"

RDEPEND="yahoo? ( >=dev-python/requests-oauthlib-0.4.0[${PYTHON_USEDEP}]
		dev-python/placefinder[${PYTHON_USEDEP}] )"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}]
		dev-python/pylint[${PYTHON_USEDEP}] )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Usual; required for testsuite
DISTUTILS_IN_SOURCE_BUILD=1

python_test() {
	# intermittent fails or errors caused by an apparent race condition. suite is fine
	nosetests --processes=-1 || die "Tests failed under ${EPYTHON}"
}
