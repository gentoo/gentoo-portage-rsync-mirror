# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/docker-py/docker-py-1.0.0.ebuild,v 1.2 2015/03/03 00:02:33 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

inherit distutils-r1

DESCRIPTION="Python client for Docker."
HOMEPAGE="https://github.com/docker/docker-py"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( >=dev-python/mkdocs-0.9[${PYTHON_USEDEP}] )
	test? ( >=dev-python/mock-1.0.1[${PYTHON_USEDEP}] )
"
RDEPEND="
	>=dev-python/requests-2.2.1[${PYTHON_USEDEP}]
	<dev-python/requests-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/websocket-client-0.11.0[${PYTHON_USEDEP}]' python2_7)
"

python_compile_all() {
	use doc && mkdocs build
}

python_test() {
	"${PYTHON}" tests/test.py || die "tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( site/. )

	distutils-r1_python_install_all
}
