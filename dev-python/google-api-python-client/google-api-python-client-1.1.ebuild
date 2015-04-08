# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/google-api-python-client/google-api-python-client-1.1.ebuild,v 1.6 2014/12/06 15:25:18 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Google API Client for Python"
HOMEPAGE="http://code.google.com/p/google-api-python-client/"
SRC_URI="https://google-api-python-client.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="
	dev-python/python-gflags[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.8[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	!dev-python/oauth2client[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
