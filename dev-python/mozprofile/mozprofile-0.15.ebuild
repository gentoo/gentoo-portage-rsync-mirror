# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mozprofile/mozprofile-0.15.ebuild,v 1.1 2013/09/12 06:46:27 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

DESCRIPTION="Handling of Mozilla XUL app profiles"
HOMEPAGE="http://github.com/mozautomation/mozmill http://pypi.python.org/pypi/mozprofile"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MPL-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-python/manifestdestiny[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
