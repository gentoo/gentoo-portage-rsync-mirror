# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/processing/processing-0.52.ebuild,v 1.7 2014/08/10 21:15:26 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Package for using processes, which mimics the threading module API"
HOMEPAGE="http://pyprocessing.berlios.de/ http://pypi.python.org/pypi/processing"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools"
RDEPEND=""

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")
