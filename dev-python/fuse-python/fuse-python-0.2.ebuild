# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fuse-python/fuse-python-0.2.ebuild,v 1.9 2012/02/22 07:26:26 patrick Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit eutils distutils

KEYWORDS="~amd64 x86"
DESCRIPTION="Python FUSE bindings"
HOMEPAGE="http://fuse.sourceforge.net/wiki/index.php/FusePython"

SRC_URI="mirror://sourceforge/fuse/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=sys-fs/fuse-2.0"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="fuse.py fuseparts"

src_prepare () {
	distutils_src_prepare
	epatch "${FILESDIR}/fuse_python_accept_none.patch"
}
