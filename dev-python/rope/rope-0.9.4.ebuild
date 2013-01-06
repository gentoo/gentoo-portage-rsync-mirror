# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rope/rope-0.9.4.ebuild,v 1.2 2012/05/28 21:23:50 floppym Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="2.7-pypy-*"

inherit distutils

DESCRIPTION="Python refactoring library"
HOMEPAGE="http://rope.sourceforge.net/ http://pypi.python.org/pypi/rope"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib:." "$(PYTHON)" ropetest/__init__.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	docinto docs
	dodoc docs/*.txt
}
