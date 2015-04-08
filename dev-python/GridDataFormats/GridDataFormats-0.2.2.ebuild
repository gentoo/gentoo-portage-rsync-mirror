# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/GridDataFormats/GridDataFormats-0.2.2.ebuild,v 1.2 2014/07/06 12:07:38 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Reading and writing of data on regular grids in Python"
HOMEPAGE="https://pypi.python.org/pypi/GridDataFormats"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	>=dev-python/numpy-1.0.3[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]"
