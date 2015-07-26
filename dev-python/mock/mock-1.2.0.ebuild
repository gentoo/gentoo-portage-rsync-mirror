# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mock/mock-1.2.0.ebuild,v 1.3 2015/07/26 14:52:45 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 pypy )

inherit distutils-r1

DESCRIPTION="Rolling backport of unittest.mock for all Pythons"
HOMEPAGE="https://github.com/testing-cabal/mock"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~hppa ~m68k ~mips ~s390 ~sh ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos"
IUSE="doc test"

CDEPEND="$(python_gen_cond_dep 'dev-python/funcsigs[${PYTHON_USEDEP}]' 'python2_7')"
DEPEND="
	>=dev-python/setuptools-17.1[${PYTHON_USEDEP}]
	>=dev-python/pbr-1.3[${PYTHON_USEDEP}]
	test? (
		${CDEPEND}
		$(python_gen_cond_dep '>=dev-python/unittest2-1.1.0[${PYTHON_USEDEP}]' 'python2_7' pypy)
	)"
RDEPEND="
	${CDEPEND}
	>=dev-python/six-1.7[${PYTHON_USEDEP}]
"

python_test() {
	# Taken from tox.ini
	"${PYTHON}" -m unittest discover || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	use doc && local DOCS=( docs/*.txt )

	distutils-r1_python_install_all
}
