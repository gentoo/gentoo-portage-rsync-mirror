# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tlslite/tlslite-0.3.8-r2.ebuild,v 1.4 2011/03/26 21:54:30 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="TLS Lite is a free python library that implements SSL 3.0 and TLS 1.0/1.1"
HOMEPAGE="http://trevp.net/tlslite/ http://pypi.python.org/pypi/tlslite"
SRC_URI="http://trevp.net/tlslite/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc gmp"

DEPEND=">=dev-libs/cryptlib-3.3.3[python]
	|| (
		dev-python/m2crypto
		dev-python/pycrypto
	)
	gmp? ( dev-python/gmpy )"
RDEPEND="${DEPEND}"

DOCS="readme.txt"
PYTHON_MODNAME="tlslite"

src_prepare() {
	distutils_src_prepare

	# Add patch for compatibility with Python 2.5 (bug #204278).
	epatch "${FILESDIR}/${P}-python25.diff"
}

src_install(){
	distutils_src_install

	if use doc; then
		dohtml -r docs/ || die "dohtml failed"
	fi
}
