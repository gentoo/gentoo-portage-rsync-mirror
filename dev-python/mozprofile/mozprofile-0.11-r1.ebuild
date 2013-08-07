# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mozprofile/mozprofile-0.11-r1.ebuild,v 1.3 2013/08/07 16:39:21 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy2_0 )
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
