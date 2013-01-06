# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/odfpy/odfpy-0.9.2.ebuild,v 1.3 2010/12/26 14:53:02 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python API and tools to manipulate OpenDocument files"
HOMEPAGE="http://opendocumentfellowship.com/development/projects/odfpy http://pypi.python.org/pypi/odfpy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="odf"

src_test() {
	testing() {
		pushd tests > /dev/null || die
		local test
		for test in test*.py; do
			echo -e "\e[1;31mRunning ${test}...\e[0m"
			PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" "${test}" || die "${test} failed with Python ${PYTHON_ABI}"
		done
		popd > /dev/null || die
	}
	python_execute_function testing
}
