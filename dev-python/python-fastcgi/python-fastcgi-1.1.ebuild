# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-fastcgi/python-fastcgi-1.1.ebuild,v 1.4 2012/02/22 07:57:33 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Interface to OpenMarket's FastCGI C Library/SDK."
HOMEPAGE="http://pypi.python.org/pypi/python-fastcgi"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/fcgi-2.4.0-r2"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="fastcgi"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-setup.patch"
}
