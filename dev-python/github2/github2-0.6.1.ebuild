# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/github2/github2-0.6.1.ebuild,v 1.2 2012/04/01 04:40:16 floppym Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

# Restricted until the third-party socks module is ported to Python 3
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Github API library"
HOMEPAGE="https://github.com/ask/python-github2 http://pypi.python.org/pypi/github2/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/httplib2-0.7.0
	dev-python/python-dateutil"
DEPEND="${RDEPEND}
	test? ( dev-python/coverage )"
