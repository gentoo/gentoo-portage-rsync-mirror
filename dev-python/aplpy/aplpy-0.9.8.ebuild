# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/aplpy/aplpy-0.9.8.ebuild,v 1.4 2012/08/02 18:07:23 bicatali Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MYP=APLpy-${PV}

DESCRIPTION="Astronomical Plotting Library in Python"
HOMEPAGE="http://aplpy.github.com/ http://pypi.python.org/pypi/APLpy"
SRC_URI="mirror://github/${PN}/${PN}/${MYP}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="dev-python/numpy
	dev-python/matplotlib
	dev-python/pyfits
	dev-python/pywcs"
DEPEND="dev-python/numpy
	test? (
		dev-python/pytest
		${RDEPEND}
	)"

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MYP}"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" runtests.py
	}
	python_execute_function testing
}
