# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vo/vo-0.8.ebuild,v 1.3 2012/08/08 19:13:19 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 *-jython"

inherit distutils eutils

DESCRIPTION="Python module to read VOTABLE into a Numpy recarray"
HOMEPAGE="https://trac6.assembla.com/astrolib/wiki http://www.scipy.org/AstroLib"
SRC_URI="http://stsdas.stsci.edu/astrolib/${P}.tar.gz"

IUSE="examples"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD"

RDEPEND="dev-libs/expat
	!dev-python/astropy"
DEPEND="${RDEPEND}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

# missing data to perform tests
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.6-expat.patch
}

src_test() {
	cd test
	testing() {
		PYTHONPATH="$(ls -d ../build-${PYTHON_ABI}/lib.*)" \
			"$(PYTHON)" benchmarks.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/
		doins -r examples
	fi
}
