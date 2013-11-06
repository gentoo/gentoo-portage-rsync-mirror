# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/medusa/medusa-0.5.4.ebuild,v 1.27 2013/11/06 05:23:44 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A framework for writing asynchronous long-running, high-performance network servers in Python"
HOMEPAGE="http://www.amk.ca/python/code/medusa.html http://pypi.python.org/pypi/medusa"
SRC_URI="http://www.amk.ca/files/python/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DOCS="CHANGES.txt docs/*.txt"

src_install() {
	distutils_src_install

	dodir /usr/share/doc/${PF}/example
	cp -r demo/* "${ED}usr/share/doc/${PF}/example"
	dohtml docs/*.html docs/*.gif
}
