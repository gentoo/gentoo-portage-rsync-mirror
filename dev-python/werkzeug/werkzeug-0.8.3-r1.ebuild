# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/werkzeug/werkzeug-0.8.3-r1.ebuild,v 1.1 2013/03/19 16:43:30 idella4 Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{5,6,7} pypy{1_9,2_0} )

inherit distutils-r1

MY_PN="Werkzeug"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Collection of various utilities for WSGI applications"
HOMEPAGE="http://werkzeug.pocoo.org/ http://pypi.python.org/pypi/Werkzeug"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-python/simplejson"
DEPEND="dev-python/setuptools
	test? ( dev-python/lxml )"
S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

PATCHES=( "${FILESDIR}"/${P}-pypytest.patch )

python_prepare() {
	# Disable redis-related tests.
	# https://github.com/mitsuhiko/werkzeug/issues/120
	sed -e "s/import redis/redis = None/" -i werkzeug/testsuite/contrib/cache.py
}

python_test() {
	PYTHONPATH="${BUILD_DIR/build/}" esetup.py test
}
