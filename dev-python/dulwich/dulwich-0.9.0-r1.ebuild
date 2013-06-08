# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dulwich/dulwich-0.9.0-r1.ebuild,v 1.1 2013/06/08 13:20:59 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Dulwich is a pure-Python implementation of the Git file formats and protocols."
HOMEPAGE="http://samba.org/~jelmer/dulwich/ http://pypi.python.org/pypi/dulwich"
SRC_URI="http://samba.org/~jelmer/dulwich/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( virtual/python-unittest2[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND=""

python_prepare_all() {
	sed -e "s/test_fetch_from_dulwich(/_&/" -i dulwich/tests/compat/server_utils.py
	use test && DISTUTILS_IN_SOURCE_BUILD=1
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	pushd "${BUILD_DIR}"/../ &> /dev/null
	local module
	for module in _diff_tree _objects _pack; do
		ln -fs "${BUILD_DIR}/lib/${PN}/${module}.so" "dulwich/${module}.so" \
		|| die "Symlinking dulwich/${module}.so failed with $(python_get_implementation_and_version)"
	done
	nosetests || die || "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}
