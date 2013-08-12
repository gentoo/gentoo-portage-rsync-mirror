# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/root_numpy/root_numpy-2.1.0.ebuild,v 1.1 2013/08/12 17:12:01 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Interface between ROOT and numpy"
HOMEPAGE="https://github.com/rootpy/root_numpy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples test"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-physics/root[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	cd ${BUILD_DIR} || die
	nosetests-${EPYTHON} -v || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r tutorial/*
	fi
}
