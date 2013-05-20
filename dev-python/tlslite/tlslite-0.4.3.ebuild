# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tlslite/tlslite-0.4.3.ebuild,v 1.3 2013/05/20 08:39:19 ago Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython"

inherit distutils

DESCRIPTION="TLS Lite is a free python library that implements SSL 3.0 and TLS 1.0/1.1"
HOMEPAGE="http://trevp.net/tlslite/ http://pypi.python.org/pypi/tlslite"
SRC_URI="http://github.com/trevp/tlslite/downloads/${P}.tar.gz"

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
#Refrain for now setting IUSE test and deps of test given test restricted.
IUSE="doc gmp"
RESTRICT="test"

DEPEND=">=dev-libs/cryptlib-3.3.3[python]
	|| (
		dev-python/m2crypto
		dev-python/pycrypto
	)
	gmp? ( dev-python/gmpy )"
RDEPEND="${DEPEND}"

# This would serve as a test phase if ever comes the time it passes all requirements; currently hangs
#src_test() {
#	testing() {
#		pushd $(ls -d build-"${PYTHON_ABI}"/lib/) > /dev/null
#		PYTHONPATH=. "${S}"/tests/tlstest.py client localhost:4443 .
#		PYTHONPATH=. "${S}"/tests/tlstest.py server localhost:4443 .
#		popd > /dev/null
#	}
#	python_execute_function testing
#}

src_install(){
	distutils_src_install

	use doc && dohtml -r docs/
}
