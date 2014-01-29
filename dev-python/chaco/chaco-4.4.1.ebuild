# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chaco/chaco-4.4.1.ebuild,v 1.1 2014/01/29 17:39:35 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 virtualx

DESCRIPTION="Enthought Tool Suite: Interactive plotting toolkit"
HOMEPAGE="http://code.enthought.com/projects/chaco/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	>=dev-python/enable-4[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/traitsui-4[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

python_test() {
	cd "${BUILD_DIR}"/lib || die
	VIRTUALX_COMMAND="nosetests" virtualmake
	rm -rf ${PN}/tests/ /${PN}/shell/ ${PN}/scales/ || die
}
