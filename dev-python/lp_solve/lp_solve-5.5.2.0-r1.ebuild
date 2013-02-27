# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lp_solve/lp_solve-5.5.2.0-r1.ebuild,v 1.1 2013/02/27 19:00:40 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1 eutils

DESCRIPTION="Python wrappers for lpsolve linear programming library"
HOMEPAGE="http://lpsolve.sourceforge.net/5.5/Python.htm"
SRC_URI="mirror://sourceforge/lpsolve/${PN}_${PV}_Python_source.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-mathematics/lpsolve"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}_5.5/extra/Python/"

PATCHES=( "${FILESDIR}"/${P}-setup.patch )

python_test() {
	PYTHONPATH="$(ls -d ${BUILD_DIR}/lib.*)" "${EPYTHON}" lpdemo.py || die
}

src_install() {
	distutils-r1_src_install
	dodoc changes
	use doc && dohtml Python.htm
	insinto /usr/share/doc/${PF}/examples
	use examples && doins ex*py
}
