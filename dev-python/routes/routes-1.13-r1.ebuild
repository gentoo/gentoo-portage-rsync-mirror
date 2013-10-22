# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/routes/routes-1.13-r1.ebuild,v 1.3 2013/10/22 14:24:30 grobian Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_PN="Routes"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python re-implementation of the Rails routes system for mapping URL's to Controllers/Actions"
HOMEPAGE="http://routes.groovie.org http://pypi.python.org/pypi/Routes"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc test"

# Note: although setup.py states that tests require webtest,
# it isn't used anywhere.
RDEPEND="dev-python/webob[${PYTHON_USEDEP}]
	dev-python/repoze-lru[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )

	distutils-r1_python_install_all
}
