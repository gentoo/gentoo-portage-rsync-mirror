# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/BitVector/BitVector-3.1.ebuild,v 1.1 2012/03/02 09:46:42 djc Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.4 2.5"

inherit distutils

DESCRIPTION="A pure-Python memory-efficient packed representation for bit arrays"
HOMEPAGE="http://cobweb.ecn.purdue.edu/~kak/dist/ http://pypi.python.org/pypi/BitVector"
SRC_URI="http://cobweb.ecn.purdue.edu/~kak/dist/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODULES="BitVector.py"

src_prepare() {
	distutils_src_prepare

	# Don't install test.py.
	rm -f test.py
}

src_test() {
	cd Test${PN}

	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" Test.py
	}
	python_execute_function testing
}
