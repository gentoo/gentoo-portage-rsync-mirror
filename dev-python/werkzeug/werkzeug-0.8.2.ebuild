# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/werkzeug/werkzeug-0.8.2.ebuild,v 1.3 2012/02/24 14:41:06 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

MY_PN="Werkzeug"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Collection of various utilities for WSGI applications"
HOMEPAGE="http://werkzeug.pocoo.org/ http://pypi.python.org/pypi/Werkzeug"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-python/simplejson"
DEPEND="dev-python/setuptools
	test? ( dev-python/lxml )"
S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_prepare() {
	distutils_src_prepare

	# Disable redis-related tests.
	# https://github.com/mitsuhiko/werkzeug/issues/120
	sed -e "s/import redis/redis = None/" -i werkzeug/testsuite/contrib/cache.py
}
