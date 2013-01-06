# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/graphcanvas/graphcanvas-3.0.0.ebuild,v 1.1 2011/02/01 02:48:40 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="GraphCanvas"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite: Interactive Graph (network) Visualization"
HOMEPAGE="http://pypi.python.org/pypi/GraphCanvas"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=dev-python/enable-3.4.0
	dev-python/networkx
	dev-python/numpy
	>=dev-python/traits-3.6.0"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "Installation of examples failed"
	fi
}
