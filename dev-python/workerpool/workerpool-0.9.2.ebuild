# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/workerpool/workerpool-0.9.2.ebuild,v 1.2 2012/05/29 10:13:22 xarthisius Exp $

EAPI=4
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"
DISTUTILS_SRC_TEST=nosetests
PYTHON_TESTS_RESTRICTED_ABIS="3.*"

inherit distutils

DESCRIPTION="Module for distributing jobs to a pool of worker threads."
HOMEPAGE="http://github.com/shazow/workerpool"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test examples"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_test() {
	distutils_src_test -v test
}

src_install() {
	distutils_src_install

	if use examples; then
		docompress -x usr/share/doc/${P}/samples
		insinto usr/share/doc/${P}/
		doins -r samples
	fi
}
