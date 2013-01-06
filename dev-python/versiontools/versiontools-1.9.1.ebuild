# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/versiontools/versiontools-1.9.1.ebuild,v 1.4 2012/04/28 12:26:19 xarthisius Exp $

EAPI=4
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="*-jython"
DISTUTILS_SRC_TEST=setup.py

inherit distutils

DESCRIPTION="Smart replacement for plain tuple used in __version__"
HOMEPAGE="http://pypi.python.org/pypi/versiontools/ https://launchpad.net/versiontools"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		PYTHONPATH="build-$(PYTHON -f --ABI)" \
			sphinx-build doc doc_output || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r doc_output/*
	fi
}
