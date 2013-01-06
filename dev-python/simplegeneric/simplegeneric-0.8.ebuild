# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simplegeneric/simplegeneric-0.8.ebuild,v 1.4 2012/01/15 22:06:32 hwoarang Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Simple generic functions for Python"
HOMEPAGE="http://pypi.python.org/pypi/simplegeneric"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools"
RDEPEND=""

PYTHON_MODNAME="${PN}.py"

src_prepare() {
	distutils_src_prepare
	sed -e "s/file(/open(/" -i setup.py || die "sed failed"
}
