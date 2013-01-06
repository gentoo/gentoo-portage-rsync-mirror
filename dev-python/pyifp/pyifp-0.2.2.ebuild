# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyifp/pyifp-0.2.2.ebuild,v 1.6 2011/01/01 21:21:14 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit eutils distutils

DESCRIPTION="Python bindings for libifp library for accessing iRiver iFP devices"
HOMEPAGE="http://ifp-gnome.sourceforge.net"
SRC_URI="mirror://sourceforge/ifp-gnome/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libifp-1.0.0.2"
DEPEND="${RDEPEND}
	dev-lang/swig"

DOCS="README.txt"
PYTHON_MODNAME="ifp.py ifp_core.py usb_core.py"

src_prepare() {
	epatch "${FILESDIR}"/${P}-setup-fix.patch
	distutils_src_prepare
}
