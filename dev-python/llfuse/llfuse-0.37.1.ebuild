# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/llfuse/llfuse-0.37.1.ebuild,v 1.4 2012/05/09 03:24:16 floppym Exp $

EAPI="4"
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 *-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="Python bindings for the low-level FUSE API"
HOMEPAGE="http://python-llfuse.googlecode.com/ http://pypi.python.org/pypi/llfuse"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=sys-fs/fuse-2.8.0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	virtual/pkgconfig"

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/html/*
}
