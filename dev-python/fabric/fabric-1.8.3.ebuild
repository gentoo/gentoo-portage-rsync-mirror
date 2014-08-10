# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fabric/fabric-1.8.3.ebuild,v 1.2 2014/08/10 21:10:24 slyfox Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN="Fabric"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A simple pythonic tool for remote execution and deployment"
HOMEPAGE="http://fabfile.org http://pypi.python.org/pypi/Fabric"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="<dev-python/paramiko-1.13[${PYTHON_USEDEP}]
	>=dev-python/paramiko-1.10.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( <dev-python/fudge-1.0[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}"/doc-extensions.patch )

python_compile_all() {
	use doc && emake -C docs html
}

src_test() {
	local DISTUTILS_NO_PARALLEL_BUILD=1
	distutils-r1_src_test
}

python_test() {
	nosetests tests || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
