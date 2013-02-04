# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsgui/traitsgui-3.6.0-r1.ebuild,v 1.3 2013/02/04 02:43:45 heroxbd Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

MY_PN="TraitsGUI"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Traits-capable windowing framework"
HOMEPAGE="http://code.enthought.com/projects/traits_gui/"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="doc examples qt4 wxwidgets"

DEPEND=">=dev-python/enthoughtbase-3.1.0
	dev-python/setuptools
	>=dev-python/traits-${PV}
	qt4? ( >=dev-python/traitsbackendqt-${PV} )
	wxwidgets? ( >=dev-python/traitsbackendwx-${PV} )
	!wxwidgets? ( !qt4? ( >=dev-python/traitsbackendwx-${PV} ) )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="docs/*.txt"
PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-namespaces.patch"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		PYTHONPATH=".." emake html || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_install() {
	find -name "*LICENSE.txt" -delete
	distutils_src_install

	if use doc; then
		dodoc docs/*.pdf || die "Installation of PDF documentation failed"
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
