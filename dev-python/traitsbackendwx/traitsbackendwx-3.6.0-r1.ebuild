# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsbackendwx/traitsbackendwx-3.6.0-r1.ebuild,v 1.1 2013/04/14 07:21:08 idella4 Exp $

EAPI=5
PYTHON_COMPAT=python2_7

inherit distutils-r1

MY_PN="TraitsBackendWX"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="WxPython backend for Traits and TraitsGUI (Pyface)"
HOMEPAGE="http://code.enthought.com/projects/traits_gui/"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/wxpython:2.8[${PYTHON_USEDEP}]
	test? ( dev-python/traitsui[${PYTHON_USEDEP}] )"
RDEPEND="dev-python/wxpython:2.8[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_test() {
	export ETS_TOOLKIT=wx
	nosetests || die
}

python_install_all() {
	find -name "*LICENSE.txt" -delete
	distutils-r1_python_install_all
}
