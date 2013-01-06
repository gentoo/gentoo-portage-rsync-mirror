# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/errorhandler/errorhandler-1.1.1.ebuild,v 1.1 2012/04/27 12:52:42 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="A logging framework handler that tracks when messages above a certain level have been logged"
HOMEPAGE="http://pypi.python.org/pypi/errorhandler"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="MIT"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND} dev-python/pkginfo
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

src_prepare() {
	sed -e 's:../bin/sphinx-build:/usr/bin/sphinx-build:' -i docs/Makefile || die
	epatch "${FILESDIR}"/${P}-test.patch
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile

	if use doc; then
		emake -C docs html
	fi
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib/" "$(PYTHON)" -c \
			"import errorhandler.tests as et, unittest; \
			unittest.TextTestRunner().run(et.test_suite())"
	}
	python_execute_function testing
}

src_install() {
	if use doc; then
		dohtml -r docs/_build/html/
	fi
	distutils_src_install
}
