# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-3.1.1.ebuild,v 1.1 2013/01/30 04:01:19 patrick Exp $

EAPI=4

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 2.7-pypy-* 3.3"
DISTUTILS_SRC_TEST=nosetests

inherit distutils eutils

DESCRIPTION="Provides an interface to FITS formatted files under python"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits http://pypi.python.org/pypi/pyfits"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-python/numpy
	dev-python/setuptools
	!dev-python/astropy"
DEPEND="${RDEPEND}
	dev-python/stsci-distutils
	dev-python/d2to1"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.0.8-debundle_zlib.patch
	distutils_src_prepare
}

src_test() {
	testing() {
		nosetests -w "$(ls -d build-${PYTHON_ABI}/lib*)"
	}
	python_execute_function testing
}
