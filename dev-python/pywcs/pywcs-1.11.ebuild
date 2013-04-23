# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywcs/pywcs-1.11.ebuild,v 1.6 2013/04/23 16:00:52 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.7-pypy-* *-jython 3.3"

inherit distutils eutils

WCS_V=4.8.2
MYP=${P}-${WCS_V}

DESCRIPTION="Python routines for handling the FITS World Coordinate System"
HOMEPAGE="https://trac6.assembla.com/astrolib/wiki http://www.scipy.org/AstroLib"
SRC_URI="http://stsdas.stsci.edu/astrolib/${MYP}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

CDEPEND=">=sci-astronomy/wcslib-${WCS_V}"
DEPEND="${CDEPEND}
	  virtual/pkgconfig"
RDEPEND="${CDEPEND}
	dev-python/pyfits
	!dev-python/astropy"

S=${WORKDIR}/${MYP}

src_prepare(){
	epatch "${FILESDIR}"/${P}-wcslib.patch
	distutils_src_prepare
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" \
			"$(PYTHON)" lib/${PN}/tests/test.py
	}
	python_execute_function testing
}

#FIX: compiles twice (once during build, another time during install)
# seems to be in the defsetup.py hack script
