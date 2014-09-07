# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/geopy/geopy-1.1.3.ebuild,v 1.2 2014/09/07 12:53:28 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="A Geocoding Toolbox for Python"
HOMEPAGE="http://www.geopy.org/ http://pypi.python.org/pypi/geopy http://code.google.com/p/geopy/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

IUSE="test yahoo"

RDEPEND="yahoo? ( $(python_gen_cond_dep '>=dev-python/requests-oauthlib-0.4.0[${PYTHON_USEDEP}]' python2_7 'python{3_3,3_4}')
		dev-python/placefinder[${PYTHON_USEDEP}] )"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}] )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( "${FILESDIR}"/${PV}-formatpy3.patch )

python_test() {
	# https://github.com/geopy/geopy/issues/74
	nosetests --processes=-1 || die "Tests failed under ${EPYTHON}"
}
