# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traits/traits-3.6.0.ebuild,v 1.6 2012/02/21 12:24:57 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

MY_PN="Traits"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite: Explicitly typed attributes for Python"
HOMEPAGE="http://code.enthought.com/projects/traits/ http://pypi.python.org/pypi/Traits"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="doc examples"

RDEPEND=">=dev-python/enthoughtbase-3.1.0
	>=dev-python/numpy-1.1
	dev-python/setuptools"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="docs/*.txt"
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
		pushd docs/build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _images _static || die "Installation of documentation failed"
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "Installation of examples failed"
	fi
}
