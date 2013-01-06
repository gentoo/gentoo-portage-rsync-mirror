# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/timelib/timelib-0.2.4.ebuild,v 1.1 2012/10/09 13:07:41 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="parse english textual date descriptions"
HOMEPAGE="http://pypi.python.org/pypi/timelib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="PHP-3.01 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools"
RDEPEND=""
