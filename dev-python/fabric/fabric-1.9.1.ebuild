# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fabric/fabric-1.9.1.ebuild,v 1.3 2014/11/06 03:27:54 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

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

RDEPEND="
	>=dev-python/paramiko-1.10[${PYTHON_USEDEP}]
	<dev-python/paramiko-1.13[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/alabaster[${PYTHON_USEDEP}] )
	test? ( <dev-python/fudge-1.0[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed -e "s/, 'sphinx.ext.intersphinx'//" -i sites/docs/conf.py || die
	distutils-r1_python_prepare_all

}

python_compile_all() {
	if use doc; then
		sphinx-build -b html -c sites/docs/ sites/docs/ sites/docs/html || die
	fi
}

src_test() {
	local DISTUTILS_NO_PARALLEL_BUILD=1
	distutils-r1_src_test
}

python_test() {
	nosetests tests || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( sites/docs/html/. )
	distutils-r1_python_install_all
}
