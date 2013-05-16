# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testtools/testtools-0.9.24-r1.ebuild,v 1.6 2013/05/16 16:33:16 ago Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1 versionator

SERIES="$(get_version_component_range 1-2)"

DESCRIPTION="Extensions to the Python unittest library"
HOMEPAGE="https://launchpad.net/testtools http://pypi.python.org/pypi/testtools"
SRC_URI="http://launchpad.net/${PN}/${SERIES}/${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

python_compile() {
	distutils-r1_python_compile

	if [[ ! -e "${BUILD_DIR}"/lib/testtools/_compat2x.py ]]; then
		die "_compat2x.py removed upstream; fix src_compile"
	fi

	# _compat2x.py is expected to have syntax incompatible with python 3.
	# This breaks compileall. Replace with "raise SyntaxError".
	# https://bugs.launchpad.net/testtools/+bug/941958
	if [[ ${EPYTHON} == python3* ]]; then
		echo "raise SyntaxError" > "${BUILD_DIR}"/lib/testtools/_compat2x.py
	fi
}

python_test() {
	# XXX: tests are non-fatal currently...
	# https://bugs.launchpad.net/testtools/+bug/1132542
	esetup.py test
}

# dev-python/subunit imports some objects from testtools.tests.helpers, so
# tests need to be installed.
