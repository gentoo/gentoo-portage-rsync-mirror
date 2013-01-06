# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/foolscap/foolscap-0.6.4.ebuild,v 1.6 2012/09/15 01:48:40 blueness Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="trial"
DISTUTILS_DISABLE_TEST_DEPENDENCY="1"

inherit distutils

DESCRIPTION="RPC protocol for Twisted"
HOMEPAGE="http://foolscap.lothar.com/trac http://pypi.python.org/pypi/foolscap"
SRC_URI="http://${PN}.lothar.com/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc ssl"

RDEPEND=">=dev-python/twisted-2.4.0
	dev-python/twisted-web
	ssl? ( dev-python/pyopenssl )"
DEPEND="${DEPEND}
	dev-python/setuptools"

src_test() {
	LC_ALL="C" distutils_src_test
}

src_install() {
	distutils_src_install

	if use doc; then
		dodoc doc/*.txt || die "dodoc failed"
		dohtml -A py,tpl,xhtml -r doc/* || die "dohtml failed"
	fi
}
