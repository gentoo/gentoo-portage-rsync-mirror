# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysyck/pysyck-0.61.2.ebuild,v 1.6 2012/11/09 18:33:48 ago Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_P="PySyck-${PV}"

DESCRIPTION="Python bindings for the Syck YAML parser and emitter"
HOMEPAGE="http://pyyaml.org/wiki/PySyck"
SRC_URI="http://pyyaml.org/download/pysyck/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/syck-0.55"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="syck"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" tests/test_syck.py
		:
	}
	python_execute_function testing

	einfo "Some tests may have failed due to pending bugs in dev-libs/syck"
}
