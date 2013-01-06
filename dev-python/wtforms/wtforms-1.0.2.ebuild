# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wtforms/wtforms-1.0.2.ebuild,v 1.2 2012/10/12 00:54:01 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

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
	doc? ( >=dev-python/sphinx-0.6 )"
RDEPEND=""

DOCS="AUTHORS.txt CHANGES.txt README.txt"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		cd docs
		PYTHONPATH=".." emake html || die "Building of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/* || die "Installation of documentation failed"
	fi
}
