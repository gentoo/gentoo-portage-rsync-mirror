# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/diff-match-patch/diff-match-patch-20120106.ebuild,v 1.2 2013/01/05 19:43:03 pinkbyte Exp $

EAPI=4

PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Diff, match and patch algorithms for plain text"
HOMEPAGE="http://code.google.com/p/google-diff-match-patch/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	distutils_src_prepare
	python_convert_shebangs -r 2 python2/*
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm "${D}/$(python_get_sitedir)/${PN//-/_}/${PN//-/_}_test.py" || die
	}

	python_execute_function -q delete_tests
}
