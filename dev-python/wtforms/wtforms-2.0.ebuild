# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wtforms/wtforms-2.0.ebuild,v 1.2 2014/05/29 12:54:20 djc Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

MY_PN="WTForms"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Flexible forms validation and rendering library for python web development"
HOMEPAGE="http://wtforms.simplecodes.com/ http://pypi.python.org/pypi/WTForms"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

S="${WORKDIR}/${MY_P}"

DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( >=dev-python/sphinx-0.6[${PYTHON_USEDEP}] )"
RDEPEND=""

DOCS="AUTHORS.txt CHANGES.txt README.txt"

python_compile_all() {
	if use doc; then
		einfo "Generation of documentation"
		cd docs
		PYTHONPATH=".." emake html
	fi
}

python_test() {
	esetup.py test || die "Tests failed for ${EPYTHON}"
}

python_install_all() {
	if use doc; then
		dohtml -r docs/_build/html/*
	fi
}
