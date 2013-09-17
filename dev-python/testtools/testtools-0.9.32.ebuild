# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testtools/testtools-0.9.32.ebuild,v 1.1 2013/09/17 18:21:08 prometheanfire Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1 versionator

#SERIES="$(get_version_component_range 1-2)"
SERIES="trunk"

DESCRIPTION="Extensions to the Python unittest library"
HOMEPAGE="https://launchpad.net/testtools http://pypi.python.org/pypi/testtools"
SRC_URI="http://launchpad.net/${PN}/${SERIES}/${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
#not keyworded
#		test? ( dev-python/mimeparse[${PYTHON_USEDEP}] ) "
RDEPEND=""

python_prepare() {
	sed -i '/\_build/d' "${S}/MANIFEST.in"
	distutils-r1_python_prepare
}

python_compile() {
	distutils-r1_python_compile

#	if [[ ! -e "${BUILD_DIR}"/lib/testtools/_compat2x.py ]]; then
#		die "_compat2x.py removed upstream; fix src_compile"
#	fi
}

python_test() {
	# XXX: tests are non-fatal currently...
	# https://bugs.launchpad.net/testtools/+bug/1132542
	esetup.py test
}

# dev-python/subunit imports some objects from testtools.tests.helpers, so
# tests need to be installed.
