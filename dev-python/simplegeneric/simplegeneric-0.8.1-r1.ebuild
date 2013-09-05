# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simplegeneric/simplegeneric-0.8.1-r1.ebuild,v 1.5 2013/09/05 18:46:38 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Simple generic functions for Python"
HOMEPAGE="http://pypi.python.org/pypi/simplegeneric"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

python_test() {
	esetup.py test
}
