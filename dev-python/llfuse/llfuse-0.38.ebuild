# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/llfuse/llfuse-0.38.ebuild,v 1.1 2013/01/06 07:46:46 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Python bindings for the low-level FUSE API"
HOMEPAGE="http://python-llfuse.googlecode.com/ http://pypi.python.org/pypi/llfuse"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=sys-fs/fuse-2.8.0"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	virtual/pkgconfig"

python_install_all() {
	distutils-r1_python_install_all
	use doc && dohtml -r doc/html/*
}
