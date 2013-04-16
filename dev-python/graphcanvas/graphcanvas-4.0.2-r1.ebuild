# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/graphcanvas/graphcanvas-4.0.2-r1.ebuild,v 1.1 2013/04/16 08:04:44 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Enthought Tool Suite: Interactive Graph (network) Visualization"
HOMEPAGE="http://pypi.python.org/pypi/graphcanvas"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

RDEPEND="dev-python/networkx
	>=dev-python/enable-4[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		docompress -x usr/share/doc/${PF}/examples/
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
