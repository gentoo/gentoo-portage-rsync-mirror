# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/envisageplugins/envisageplugins-3.2.0-r1.ebuild,v 1.1 2013/04/14 10:31:36 idella4 Exp $

EAPI=5
PYTHON_COMPAT=python2_7

inherit distutils-r1

MY_PN="EnvisagePlugins"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite: Plug-ins for the Envisage framework"
HOMEPAGE="http://code.enthought.com/projects/envisage_plugins.php"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="examples test"

RDEPEND=">=dev-python/envisage-4.0.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

S="${WORKDIR}/${MY_P}"

# Set dep to >=dev-python/envisage-4
PATCHES=( "${FILESDIR}"/set-INFO.patch )

python_test() {
	export ETS_TOOLKIT=wx
	nosetests || die
}

python_install_all() {
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	distutils-r1_python_install_all
}
