# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oauthlib/oauthlib-0.3.4.ebuild,v 1.3 2013/01/06 19:43:52 mgorny Exp $

EAPI="4"

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="A generic, spec-compliant, thorough implementation of the OAuth request-signing logic"
HOMEPAGE="https://github.com/idan/oauthlib
	http://pypi.python.org/pypi/oauthlib"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

# >=pycrypto-2.6-r1 for python3 support
# unittest2 for python2 compat
RDEPEND=">=dev-python/pycrypto-2.6-r1"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? (
		virtual/python-unittest2
		dev-python/mock
	)"
