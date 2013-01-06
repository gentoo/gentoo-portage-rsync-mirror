# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyelemental/pyelemental-1.2.0.ebuild,v 1.6 2012/07/08 17:42:28 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils eutils

DESCRIPTION="Python bindings for libelemental (sci-chemistry/gelemental)"
HOMEPAGE="http://freecode.com/projects/gelemental/"
SRC_URI="http://www.kdau.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=sci-chemistry/gelemental-1.2.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-4.7.patch
	distutils_src_prepare
}

src_install() {
	distutils_src_install
	dohtml docs/html/*.html || die "dohtml failed"
}
