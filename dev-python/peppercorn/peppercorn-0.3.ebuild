# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/peppercorn/peppercorn-0.3.ebuild,v 1.1 2011/07/30 01:57:57 rafaelmartins Exp $

EAPI=3

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="A library for converting a token stream into a data structure for use in web form posts"
HOMEPAGE="http://docs.repoze.org/peppercorn http://pypi.python.org/pypi/peppercorn"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )"
RDEPEND=""

src_compile() {
	distutils_src_compile

	if use doc; then
		(cd docs && emake html) || die "make html failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/.build/html/* || die "dohtml failed"
	fi
}
