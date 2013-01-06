# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cffi/cffi-0.2.1.ebuild,v 1.3 2012/12/05 10:22:25 ssuominen Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.5 2.5-jython"

inherit distutils

DESCRIPTION="Foreign Function Interface for Python calling C code."
HOMEPAGE="http://cffi.readthedocs.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libffi
	dev-python/pycparser
	dev-python/pytest"
RDEPEND="${DEPEND}"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" py.test c/ testing/ -x
	}
	python_execute_function testing
}
