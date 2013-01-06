# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpy/rpy-2.2.6-r1.ebuild,v 1.1 2012/11/13 07:05:41 jlec Exp $

EAPI=4
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 *-jython 2.7-pypy-*"

inherit distutils

MYSLOT=2
MY_PN=${PN}${MYSLOT}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python interface to the R Programming Language"
HOMEPAGE="http://rpy.sourceforge.net/ http://pypi.python.org/pypi/rpy2"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-lang/R-2.8
	dev-python/numpy
	!<=dev-python/rpy-1.0.2-r2"
DEPEND="${RDEPEND}"

PYTHON_MODNAME=${MY_PN}
PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

S=${WORKDIR}/${MY_P}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" \
			"$(PYTHON)" -m 'rpy2.tests'
	}
	python_execute_function testing
}
