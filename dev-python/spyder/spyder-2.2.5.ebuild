# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/spyder/spyder-2.2.5.ebuild,v 1.1 2014/03/03 20:59:40 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 eutils

DESCRIPTION="Python IDE with matlab-like features"
HOMEPAGE="http://code.google.com/p/spyderlib/"
SRC_URI="http://spyderlib.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc ipython matplotlib numpy pep8 +pyflakes pylint +rope scipy sphinx"

RDEPEND="
	|| ( dev-python/PyQt4[${PYTHON_USEDEP},svg,webkit]
		 dev-python/pyside[${PYTHON_USEDEP},svg,webkit] )
	ipython? ( dev-python/ipython[${PYTHON_USEDEP}] )
	matplotlib? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
	numpy? ( dev-python/numpy[${PYTHON_USEDEP}] )
	pep8? ( dev-python/pep8[${PYTHON_USEDEP}] )
	pyflakes? ( >=dev-python/pyflakes-0.3[${PYTHON_USEDEP}] )
	pylint? ( dev-python/pylint[${PYTHON_USEDEP}] )
	rope? ( >=dev-python/rope-0.9.3[${PYTHON_USEDEP}] )
	scipy? ( sci-libs/scipy[${PYTHON_USEDEP}] )
	sphinx? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( dev-python/sphinx )"

PATCHES=( "${FILESDIR}"/${PN}-2.2.5-disable_sphinx_dependency.patch )

python_compile() {
	if use doc; then
		einfo "Generation of documentation"
		PYTHONPATH="{BUILD_DIR}" \
			sphinx-build doc doc_output || die "Generation of documentation failed"
	fi
}

python_install_all() {
	distutils-r1_python_install_all
	doicon spyderlib/images/spyder.svg
	make_desktop_entry spyder Spyder spyder "Development;IDE"
	use doc && dohtml -r doc_output/*
}
