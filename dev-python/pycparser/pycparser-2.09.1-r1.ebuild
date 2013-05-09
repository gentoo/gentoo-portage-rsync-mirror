# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycparser/pycparser-2.09.1-r1.ebuild,v 1.3 2013/05/09 12:19:45 maekke Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="C parser and AST generator written in Python"
HOMEPAGE="https://bitbucket.org/eliben/pycparser/"
SRC_URI="https://bitbucket.org/eliben/${PN}/get/release_v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

RDEPEND="dev-python/ply[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_compile() {
	distutils-r1_python_compile
	pushd "${BUILD_DIR}/lib/pycparser" > /dev/null || die
	"${PYTHON}" _build_tables.py || die
	popd > /dev/null || die
}

python_test() {
	nosetests || die
}
