# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyliblzma/pyliblzma-0.5.3-r1.ebuild,v 1.1 2013/01/06 07:55:04 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python bindings for liblzma"
HOMEPAGE="https://launchpad.net/pyliblzma http://pypi.python.org/pypi/pyliblzma"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-arch/xz-utils"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	virtual/pkgconfig"

DOCS="THANKS"

python_test() {
	esetup.py test
}
