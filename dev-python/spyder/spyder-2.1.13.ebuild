# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/spyder/spyder-2.1.13.ebuild,v 1.2 2013/03/01 13:49:19 xarthisius Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython 2.7-pypy-*"

inherit distutils eutils

DESCRIPTION="Python IDE with matlab-like features"
HOMEPAGE="http://code.google.com/p/spyderlib/ http://pypi.python.org/pypi/spyder"
SRC_URI="http://spyderlib.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc ipython matplotlib numpy pep8 +pyflakes pylint +rope scipy sphinx"

RDEPEND=">=dev-python/PyQt4-4.4[svg,webkit]
	ipython? ( dev-python/ipython )
	matplotlib? ( dev-python/matplotlib )
	numpy? ( dev-python/numpy )
	pep8? ( dev-python/pep8 )
	pyflakes? ( >=dev-python/pyflakes-0.3 )
	pylint? ( dev-python/pylint )
	rope? ( >=dev-python/rope-0.9.3 )
	scipy? ( sci-libs/scipy )
	sphinx? ( dev-python/sphinx )"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( dev-python/sphinx )"

PYTHON_MODNAME="spyderlib spyderplugins"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/${PN}-2.1.13-disable_sphinx_dependency.patch
}

src_compile() {
	distutils_src_compile
	if use doc; then
		einfo "Generation of documentation"
		PYTHONPATH="build-$(PYTHON -f --ABI)" \
			sphinx-build doc doc_output || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install
	doicon spyderlib/images/spyder.svg
	make_desktop_entry spyder Spyder spyder "Development;IDE"
	if use doc; then
		pushd doc_output > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _images _static
		popd > /dev/null
	fi
}
