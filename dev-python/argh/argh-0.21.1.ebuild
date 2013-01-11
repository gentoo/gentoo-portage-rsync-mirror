# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/argh/argh-0.21.1.ebuild,v 1.1 2013/01/11 06:19:46 patrick Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 2.5-jython"
PYTHON_MODNAME="argh"

inherit distutils eutils

DESCRIPTION="A simple argparse wrapper."
HOMEPAGE="http://packages.python.org/argh/"
SRC_URI="mirror://pypi/a/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-3"

RDEPEND=""
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.17.2-setup.py.patch"
	distutils_src_prepare
}
