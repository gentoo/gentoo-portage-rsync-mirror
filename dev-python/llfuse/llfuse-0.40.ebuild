# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/llfuse/llfuse-0.40.ebuild,v 1.3 2014/04/03 06:52:22 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Python bindings for the low-level FUSE API"
HOMEPAGE="http://python-llfuse.googlecode.com/ http://pypi.python.org/pypi/llfuse"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND=">=sys-fs/fuse-2.8.0"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	virtual/pkgconfig"

python_prepare_all() {
	# use system setuptools
	sed -i '/use_setuptools/d' setup.py || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/html/. )
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
