# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyamg/pyamg-2.0.5.ebuild,v 1.2 2013/09/05 18:46:40 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Algebraic multigrid solvers in Python"
HOMEPAGE="http://code.google.com/p/pyamg/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RESTRICT="test" # quite buggy

RDEPEND="sci-libs/scipy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}"

python_compile_all() {
	if use doc; then
		cd "${S}/Docs"
		PYTHONPATH="${BUILD_DIR}"/lib emake html
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( Docs/build/html/* )
	distutils-r1_python_install_all
}
