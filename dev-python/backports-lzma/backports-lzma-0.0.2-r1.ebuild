# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/backports-lzma/backports-lzma-0.0.2-r1.ebuild,v 1.2 2014/03/06 23:18:42 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2} )

inherit distutils-r1

MY_PN=${PN/-/.}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Backport of Python 3.3's lzma module for XZ/LZMA compressed files"
HOMEPAGE="https://github.com/peterjc/backports.lzma/ http://pypi.python.org/pypi/backports.lzma/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="app-arch/xz-utils
	dev-python/backports[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# main namespace provided by dev-python/backports
	rm backports/__init__.py || die
}

python_test() {
	"${PYTHON}" test/test_lzma.py || die "tests failed with ${EPYTHON}"
}
