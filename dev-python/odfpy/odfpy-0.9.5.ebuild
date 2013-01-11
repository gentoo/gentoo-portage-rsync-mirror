# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/odfpy/odfpy-0.9.5.ebuild,v 1.1 2013/01/11 06:46:27 patrick Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Python API and tools to manipulate OpenDocument files"
HOMEPAGE="https://joinup.ec.europa.eu/software/odfpy/home http://pypi.python.org/pypi/odfpy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="odf"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-0.9.4-tests.patch"
}

src_test() {
	cd tests || die
	testing() {
		local exit_status=0 test
		for test in test*.py; do
			einfo "Running ${test} ..."
			PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" "${test}"
			[[ $? -ne 0 ]] && exit_status=1
		done
		return ${exit_status}
	}
	python_execute_function testing
}
