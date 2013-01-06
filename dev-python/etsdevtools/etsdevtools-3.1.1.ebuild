# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/etsdevtools/etsdevtools-3.1.1.ebuild,v 1.7 2012/02/23 04:53:07 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

MY_PN="ETSDevTools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought tools to support Python development"
HOMEPAGE="http://code.enthought.com/projects/dev_tools.php http://pypi.python.org/pypi/ETSDevTools"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="doc examples wxwidgets"

RDEPEND="dev-python/docutils
	dev-python/nose
	dev-python/numpy
	dev-python/setuptools
	>=dev-python/traitsgui-3.6.0
	wxwidgets? ( dev-python/wxpython:2.8 )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_install() {
	find -name "*LICENSE.txt" -delete
	distutils_src_install

	if use doc; then
		dodoc docs/*/*.pdf || die "Installation of PDF documentation failed"
		pushd docs/build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "Installation of examples failed"
	fi
}
