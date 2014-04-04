# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simplegeneric/simplegeneric-0.8.1-r1.ebuild,v 1.11 2014/04/04 07:35:58 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Simple generic functions for Python"
HOMEPAGE="http://pypi.python.org/pypi/simplegeneric"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 arm ~ia64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

python_test() {
	esetup.py test
}
