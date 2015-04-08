# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jedi/jedi-0.8.0.ebuild,v 1.1 2014/05/10 22:40:51 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_2 python3_3 )
inherit distutils-r1

MY_PV="${PV/_beta/b}-final0"

DESCRIPTION="Awesome autocompletion library for python"
HOMEPAGE="https://github.com/davidhalter/jedi"
SRC_URI="mirror://pypi/j/jedi/jedi-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="app-arch/xz-utils
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx )
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/tox[${PYTHON_USEDEP}]
	)"

S=${WORKDIR}/${PN}-${MY_PV}

python_test() {
	PYTHONPATH="${PYTHONPATH%:}${PYTHONPATH+:}${S}/test" py.test test || die "Tests failed under ${EPYTHON}"
}

src_compile() {
	if use doc ; then
		emake -C docs html
	fi
	distutils-r1_src_compile
}

python_install_all() {
	use doc && dohtml -r "${S}"/docs/_build/html/*
	distutils-r1_python_install_all
}
