# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/routes/routes-2.0.ebuild,v 1.5 2015/03/08 23:58:22 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

MY_PN="Routes"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python re-implementation of the Rails routes system for mapping URL's to Controllers/Actions"
HOMEPAGE="http://routes.groovie.org http://pypi.python.org/pypi/Routes"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc test"

RDEPEND="dev-python/webob[${PYTHON_USEDEP}]
	>=dev-python/repoze-lru-0.3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/webtest[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${PN}-2.0-tests-py3.patch
	"${FILESDIR}"/${PN}-2.0-setup.py.patch
)

python_prepare_all() {
	use test && DISTUTILS_IN_SOURCE_BUILD=1
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	cp -r tests "${BUILD_DIR}" || die
	if [[ ${EPYTHON} == python3* ]]; then
		2to3 -w --no-diffs "${BUILD_DIR}"/tests || die
	fi

	nosetests -w "${BUILD_DIR}"/tests || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
