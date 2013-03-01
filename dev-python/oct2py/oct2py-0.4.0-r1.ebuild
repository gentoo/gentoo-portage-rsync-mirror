# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oct2py/oct2py-0.4.0-r1.ebuild,v 1.1 2013/03/01 12:32:09 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python to GNU Octave bridge"
HOMEPAGE="http://pypi.python.org/pypi/oct2py"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND="
	sci-libs/scipy[${PYTHON_USEDEP}]
	sci-mathematics/octave"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_compile_all() {
	if use doc; then
		sphinx-build doc html || die
	fi
}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( html/. )
	distutils-r1_python_install_all

	if use examples; then
		insinto /usr/share/${PF}/
		doins -r example
	fi
}
