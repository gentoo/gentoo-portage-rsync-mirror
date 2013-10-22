# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pastescript/pastescript-1.7.5-r2.ebuild,v 1.4 2013/10/22 14:16:04 grobian Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN="PasteScript"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A pluggable command-line frontend, including commands to setup package file layouts"
HOMEPAGE="http://pythonpaste.org/script/ http://pypi.python.org/pypi/PasteScript"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc"

RDEPEND="
	dev-python/cheetah[${PYTHON_USEDEP}]
	>=dev-python/paste-1.3[${PYTHON_USEDEP}]
	dev-python/pastedeploy[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	doc? (
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		)"

# Tests are broken.
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${PN}-setup.py-exclude-tests.patch" )

python_compile_all() {
	if use doc; then
		einfo "Generation of documentation"
		esetup.py build_sphinx
	fi
}

python_install_all() {
	distutils-r1_python_install_all

	if use doc; then
		cd "${BUILD_DIR}"/sphinx/html || die
		dohtml -r [a-z]* _static
	fi
}
