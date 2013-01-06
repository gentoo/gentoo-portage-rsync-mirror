# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/translationstring/translationstring-0.4.ebuild,v 1.1 2012/02/08 07:03:58 patrick Exp $

EAPI=3

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Utility library for i18n relied on by various Repoze packages"
HOMEPAGE="http://www.repoze.org/ http://pypi.python.org/pypi/translationstring"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? ( dev-python/Babel )"
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
