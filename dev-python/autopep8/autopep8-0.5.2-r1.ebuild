# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/autopep8/autopep8-0.5.2-r1.ebuild,v 1.2 2012/06/16 13:39:00 sping Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5-cpython"

inherit eutils distutils

DESCRIPTION="Automatically formats Python code to conform to the PEP 8 style guide"
HOMEPAGE="https://github.com/hhatto/autopep8 http://pypi.python.org/pypi/autopep8"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dev-python/pep8-1.3
	dev-python/setuptools"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="${PN}.py"

src_prepare() {
	epatch "${FILESDIR}"/${P}-issue-10.patch
	distutils_src_prepare
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/test_${PN}.py
	}
	python_execute_function testing
}
