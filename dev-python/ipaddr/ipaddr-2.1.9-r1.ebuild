# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipaddr/ipaddr-2.1.9-r1.ebuild,v 1.1 2013/06/24 06:40:12 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Python IP address manipulation library"
HOMEPAGE="http://code.google.com/p/ipaddr-py/ http://pypi.python.org/pypi/ipaddr"
SRC_URI="http://ipaddr-py.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND=""

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS=( README RELEASENOTES )

python_prepare_all() {
	use test && DISTUTILS_IN_SOURCE_BUILD=1
	distutils-r1_python_prepare_all
}

python_test() {
	pushd "${BUILD_DIR}"/../ &> /dev/null
	if [[ "${EPYTHON}" == python3* ]]; then
		2to3 -nw --no-diffs ipaddr.py ipaddr_test.py
	fi
	"${PYTHON}" ipaddr_test.py || die "Tests failed under ${EPYTHON}"
}
