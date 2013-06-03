# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/whirlpool/whirlpool-0.3.ebuild,v 1.1 2013/06/03 19:49:24 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN="Whirlpool"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Bindings for whirlpool hash reference implementation"
HOMEPAGE="https://pypi.python.org/pypi/Whirlpool https://github.com/radiosilence/python-whirlpool"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( virtual/python-unittest2[${PYTHON_USEDEP}] )"

S="${WORKDIR}"/${MY_P}

python_test() {
	${PYTHON} "${FILESDIR}"/tests.py || die
}
