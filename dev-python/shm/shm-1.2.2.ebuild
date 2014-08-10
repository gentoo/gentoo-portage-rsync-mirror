# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/shm/shm-1.2.2.ebuild,v 1.9 2014/08/10 21:22:01 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils eutils

DESCRIPTION="Python modules to access System V shared memory and semaphores"
HOMEPAGE="http://nikitathespider.com/python/shm/"
SRC_URI="http://nikitathespider.com/python/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-compiler.patch"
}

src_install() {
	distutils_src_install

	dohtml ReadMe.html
	insinto /usr/share/doc/${PF}
	doins -r demo
}
