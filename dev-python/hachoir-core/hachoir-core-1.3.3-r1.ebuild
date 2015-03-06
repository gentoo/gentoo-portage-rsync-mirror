# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hachoir-core/hachoir-core-1.3.3-r1.ebuild,v 1.3 2015/03/06 22:23:15 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Core of Hachoir framework: parse and edit binary files"
HOMEPAGE="http://bitbucket.org/haypo/hachoir/wiki/hachoir-core http://pypi.python.org/pypi/hachoir-core"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_configure_all() {
	mydistutilsargs=( --setuptools )
}

python_test() {
	"${PYTHON}" test_doc.py || die "Tests fail with ${EPYTHON}"
}
