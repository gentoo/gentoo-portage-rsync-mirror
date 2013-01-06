# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/envisageplugins/envisageplugins-3.2.0.ebuild,v 1.5 2012/11/08 20:56:10 idella4 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils virtualx

MY_PN="EnvisagePlugins"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite: Plug-ins for the Envisage framework"
HOMEPAGE="http://code.enthought.com/projects/envisage_plugins.php"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"
RESTRICT="test"

RDEPEND=">=dev-python/envisagecore-3.2.0
	dev-python/setuptools
	>=dev-python/traitsgui-3.6.0"
DEPEND="${RDEPEND}
	test? (
		dev-python/coverage
		dev-python/nose
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		x11-apps/xhost
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_test() {
	VIRTUALX_COMMAND="distutils_src_test" virtualmake
}

src_install() {
	find -name "*LICENSE.txt" -delete
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "Installation of examples failed"
	fi
}
