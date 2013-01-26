# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wsgiref/wsgiref-0.1.2.ebuild,v 1.6 2013/01/26 05:53:15 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_1 )

inherit distutils-r1

DESCRIPTION="WSGI (PEP 333) Reference Library"
HOMEPAGE="http://cheeseshop.python.org/pypi/wsgiref"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="|| ( PSF-2 ZPL )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
