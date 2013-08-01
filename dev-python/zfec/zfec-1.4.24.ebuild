# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/zfec/zfec-1.4.24.ebuild,v 1.1 2013/08/01 01:54:43 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )
inherit distutils-r1

DESCRIPTION="Fast erasure codec which can be used with the command-line, C, Python, or Haskell"
HOMEPAGE="https://pypi.python.org/pypi/zfec"
SRC_URI="mirror://pypi/z/zfec/zfec-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="virtual/python-argparse[${PYTHON_USEDEP}]"
RDEPEND="${COMMON_DEPEND}
	dev-python/pyutil[${PYTHON_USEDEP}]"
DEPEND="${COMMON_DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install

	rm -rf "${ED%/}"/usr/share/doc/${PN}
}
