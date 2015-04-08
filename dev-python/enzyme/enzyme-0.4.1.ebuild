# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enzyme/enzyme-0.4.1.ebuild,v 1.2 2014/11/27 15:23:42 pacho Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Python video metadata parser"
HOMEPAGE="https://github.com/Diaoul/enzyme https://pypi.python.org/pypi/enzyme"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	test? ( http://downloads.sourceforge.net/project/matroska/test_files/matroska_test_w1_1.zip )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)
	dev-python/setuptools[${PYTHON_USEDEP}]
"

python_prepare_all() {
	if use test; then
		mkdir enzyme/tests/test_{parsers,mkv} || die
		ln -s "${WORKDIR}"/test* enzyme/tests/test_parsers/ || die
		ln -s "${WORKDIR}"/test* enzyme/tests/test_mkv/ || die
	fi

	distutils-r1_python_prepare_all
}

python_test() {
	esetup.py test
}
