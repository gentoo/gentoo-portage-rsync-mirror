# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eunuchs/eunuchs-20050320.1.ebuild,v 1.4 2012/01/06 21:25:55 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Missing manly parts of UNIX API for Python"
HOMEPAGE="http://www.inoi.fi/open/trac/eunuchs http://pypi.python.org/pypi/python-eunuchs"
SRC_URI="mirror://debian/pool/main/e/${PN}/${PN}_${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-python-2.5.patch"
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" examples/test-socketpair.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	docinto examples
	dodoc examples/*
}
