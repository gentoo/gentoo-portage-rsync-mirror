# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyasn1/pyasn1-0.1.6.ebuild,v 1.1 2013/01/08 15:56:20 idella4 Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

DESCRIPTION="ASN.1 library for Python"
HOMEPAGE="http://pyasn1.sourceforge.net/ http://pypi.python.org/pypi/pyasn1"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="dev-python/setuptools"
RDEPEND=""

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib:." "$(PYTHON)" test/suite.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml doc/*
	else
		dohtml doc/pyasn1-tutorial.html
	fi
}
