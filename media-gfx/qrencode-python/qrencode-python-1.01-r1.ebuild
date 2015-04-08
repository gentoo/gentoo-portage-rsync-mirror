# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qrencode-python/qrencode-python-1.01-r1.ebuild,v 1.1 2013/06/10 15:13:19 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A simple wrapper for the C qrencode library"
HOMEPAGE="http://pypi.python.org/pypi/qrencode/ https://github.com/Arachnid/pyqrencode/"
SRC_URI="mirror://pypi/q/qrencode/qrencode-${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="Apache-2.0"
IUSE=""

RDEPEND="
	virtual/python-imaging[${PYTHON_USEDEP}]
	media-gfx/qrencode"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/qrencode-${PV}

PATCHES=( "${FILESDIR}"/${P}-PIL.patch )
