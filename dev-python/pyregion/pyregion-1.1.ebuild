# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyregion/pyregion-1.1.ebuild,v 1.1 2013/04/25 16:50:45 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit distutils-r1

DESCRIPTION="Python module to parse ds9 region file"
HOMEPAGE="http://leejjoon.github.com/pyregion/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="MIT"

IUSE="examples"
RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]"
DEPEND="${DEPEND}
	|| ( dev-python/cython[${PYTHON_USEDEP}]
		 dev-python/pyrex[${PYTHON_USEDEP}] )"

python_install_all() {
	dodoc README
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
