# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/execnet/execnet-1.0.9.ebuild,v 1.1 2010/12/24 02:08:53 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="py.test"

inherit distutils

DESCRIPTION="Rapid multi-Python deployment"
HOMEPAGE="http://codespeak.net/execnet/ http://pypi.python.org/pypi/execnet/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="app-arch/unzip
	dev-python/setuptools
	doc? ( dev-python/sphinx )"
RDEPEND=""

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		cd doc
		emake html || die "Generation of documentation failed"
	fi
}

src_test() {
	distutils_src_test testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/_build/html/* || die "Installation of documentation failed"
	fi
}
