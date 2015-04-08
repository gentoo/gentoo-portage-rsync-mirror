# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traits/traits-4.3.0-r1.ebuild,v 1.5 2015/04/08 08:05:24 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 virtualx

DESCRIPTION="Enthought Tool Suite: Explicitly typed attributes for Python"
HOMEPAGE="http://code.enthought.com/projects/traits/ http://pypi.python.org/pypi/traits"
SRC_URI="http://www.enthought.com/repo/ETS/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/numpy[${PYTHON_USEDEP}] )"

python_prepare_all() {
	sed -i -e "s/'-O3'//g" setup.py || die
	distutils-r1_python_prepare_all
}

python_compile() {
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
	distutils-r1_python_compile
}

python_compile_all() {
	use doc && virtualmake -C docs html
}

python_test() {
	cd "${BUILD_DIR}"/lib || die
	nosetests || die
}

python_install_all() {
	local DOCS=( docs/*.txt )
	use doc && HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
