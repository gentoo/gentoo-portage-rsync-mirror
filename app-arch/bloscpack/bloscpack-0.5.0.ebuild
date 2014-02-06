# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bloscpack/bloscpack-0.5.0.ebuild,v 1.1 2014/02/06 01:30:04 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Command line interface for Blosc compression"
HOMEPAGE="https://github.com/Blosc/bloscpack"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/blosc[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
