# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ujson/ujson-1.30.ebuild,v 1.1 2013/02/24 09:56:11 swegener Exp $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="*:2.4"

inherit distutils

DESCRIPTION="Ultra fast JSON encoder and decoder for Python"
HOMEPAGE="http://pypi.python.org/pypi/ujson/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
