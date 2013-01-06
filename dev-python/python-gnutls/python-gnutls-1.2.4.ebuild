# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gnutls/python-gnutls-1.2.4.ebuild,v 1.2 2012/02/22 03:58:12 patrick Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
PYTHON_MODNAME="gnutls"

inherit distutils

DESCRIPTION="Python bindings for GnuTLS"
HOMEPAGE="http://pypi.python.org/pypi/python-gnutls http://ag-projects.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos ~x64-macos ~x86-macos"
IUSE="examples"

DEPEND="net-libs/gnutls"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
