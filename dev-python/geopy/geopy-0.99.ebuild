# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/geopy/geopy-0.99.ebuild,v 1.2 2014/06/30 04:45:51 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="A Geocoding Toolbox for Python"
HOMEPAGE="http://www.geopy.org/ http://pypi.python.org/pypi/geopy http://code.google.com/p/geopy/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
IUSE="test yahoo"

RDEPEND="yahoo? ( >=dev-python/requests-oauthlib-0.4.0[$(python_gen_usedep 'python2*' python3_3)] )"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="yahoo? ( || ( $(python_gen_useflags 'python2*' python3_3) ) )"

python_test() {
	nosetests || die "Tests failed under ${EPYTHON}"
}
