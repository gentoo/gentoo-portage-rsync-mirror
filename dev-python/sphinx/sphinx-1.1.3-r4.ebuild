# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sphinx/sphinx-1.1.3-r4.ebuild,v 1.1 2013/01/14 00:03:38 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2} pypy1_9 )

inherit distutils-r1

MY_PN="Sphinx"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python documentation generator"
HOMEPAGE="http://sphinx.pocoo.org/ http://pypi.python.org/pypi/Sphinx"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc latex test"

RDEPEND=">=dev-python/docutils-0.7[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.3[${PYTHON_USEDEP}]
	>=dev-python/pygments-1.2[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	latex? (
		dev-texlive/texlive-latexextra
		app-text/dvipng
	)"
DEPEND="${DEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${P}-python3.patch
)

python_compile() {
	distutils-r1_python_compile

	if use test; then
		cp -r -l tests "${BUILD_DIR}"/lib || die

		if [[ ${EPYTHON} == python3* ]]; then
			2to3 -w --no-diffs "${BUILD_DIR}"/lib/tests || die
		fi
	fi
}

python_compile_all() {
	use doc && emake -C doc SPHINXBUILD="${PYTHON} -m sphinx.__init__" html
}

python_test() {
	nosetests -w "${BUILD_DIR}"/lib/tests || ewarn "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/_build/html/. )

	distutils-r1_python_install_all
}
