# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/enthoughtbase/enthoughtbase-3.1.0.ebuild,v 1.11 2013/05/12 14:37:51 idella4 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils virtualx

MY_PN="EnthoughtBase"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Core packages for the Enthought Tool Suite"
HOMEPAGE="http://code.enthought.com/projects/enthought_base/"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"
RESTRICT="test"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	test? (
		dev-python/nose
		dev-python/traits
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		x11-apps/xhost
	)"

S="${WORKDIR}/${MY_P}"

DOCS="docs/*.txt"
PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare

	if ! has_version sci-libs/scipy; then
		# enthought/util/tests/test_numeric.py imports deprecated enthought.util.numeric module, which depends on scipy.
		rm -f enthought/util/tests/test_numeric.py
	fi
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_test() {
	VIRTUALX_COMMAND="distutils_src_test" virtualmake
}

src_install() {
	find -name "*LICENSE.txt" -delete
	distutils_src_install

	if use doc; then
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
