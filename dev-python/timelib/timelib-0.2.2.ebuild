# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/timelib/timelib-0.2.2.ebuild,v 1.2 2012/02/20 14:52:46 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.7-pypy-*"

inherit distutils

DESCRIPTION="parse english textual date descriptions"
HOMEPAGE="http://pypi.python.org/pypi/timelib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZLIB PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

PYTHON_CFLAGS=("* + -fno-strict-aliasing")
