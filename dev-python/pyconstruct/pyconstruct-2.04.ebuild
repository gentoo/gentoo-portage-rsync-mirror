# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyconstruct/pyconstruct-2.04.ebuild,v 1.2 2011/09/16 15:09:42 mr_bones_ Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit distutils

MY_PN="construct"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A powerful declarative parser for binary data"
HOMEPAGE="http://construct.wikispaces.com/ http://pypi.python.org/pypi/construct"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="app-arch/unzip
	doc? ( dev-python/sphinx )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

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

pkg_postinst() {
	python_mod_optimize construct
}

pkg_postrm() {
	python_mod_cleanup construct
}
