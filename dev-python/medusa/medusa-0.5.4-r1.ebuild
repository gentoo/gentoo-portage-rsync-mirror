# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/medusa/medusa-0.5.4-r1.ebuild,v 1.9 2014/03/02 10:44:33 pacho Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="A framework for writing asynchronous long-running, high-performance network servers in Python"
HOMEPAGE="http://www.amk.ca/python/code/medusa.html http://pypi.python.org/pypi/medusa"
SRC_URI="http://www.amk.ca/files/python/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

python_install_all() {
	distutils-r1_python_install_all
	dodoc CHANGES.txt docs/*.txt
	dodir /usr/share/doc/${PF}/example
	cp -r demo/* "${ED}usr/share/doc/${PF}/example"
	dohtml docs/*.html docs/*.gif
}
