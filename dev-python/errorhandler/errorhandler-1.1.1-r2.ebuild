# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/errorhandler/errorhandler-1.1.1-r2.ebuild,v 1.3 2015/03/08 23:46:48 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="A logging framework handler that tracks when messages above a certain level have been logged"
HOMEPAGE="http://pypi.python.org/pypi/errorhandler"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="amd64 x86"
IUSE="doc"

LICENSE="MIT"
SLOT="0"

RDEPEND=""
DEPEND="
	dev-python/pkginfo[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_prepare_all() {
	sed -e 's:../bin/sphinx-build:/usr/bin/sphinx-build:' -i docs/Makefile || die
	epatch "${FILESDIR}"/${P}-test.patch \
		"${FILESDIR}"/docs.patch
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	"${PYTHON}" -c "import errorhandler.tests as et, unittest; \
		unittest.TextTestRunner().run(et.test_suite())" \
		|| die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
