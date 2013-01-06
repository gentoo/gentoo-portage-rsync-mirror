# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tlslite/tlslite-0.4.0.ebuild,v 1.4 2012/06/25 07:43:28 jdhore Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.* *-jython"

inherit distutils

DESCRIPTION="TLS Lite is a free python library that implements SSL 3.0 and TLS 1.0/1.1"
HOMEPAGE="http://trevp.net/tlslite/ http://pypi.python.org/pypi/tlslite"
SRC_URI="http://github.com/trevp/tlslite/downloads/${P}.tar.gz"

LICENSE="BSD public-domain"
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

PYTHON_MODNAME="tlslite"

src_install(){
	distutils_src_install

	if use doc; then
		dohtml -r docs/
	fi
}
