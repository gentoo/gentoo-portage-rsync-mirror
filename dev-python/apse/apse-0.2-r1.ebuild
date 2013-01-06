# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apse/apse-0.2-r1.ebuild,v 1.3 2012/02/21 05:02:17 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="Apse"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Approximate String Matching in Python."
HOMEPAGE="http://www.personal.psu.edu/staff/i/u/iua1/python/apse/"
SRC_URI="http://www.personal.psu.edu/staff/i/u/iua1/python/${PN}/dist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="dev-lang/swig"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="README* *agrep"
PYTHON_MODNAME="Apse.py"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" test/test_Apse.py
	}
	python_execute_function testing
}
