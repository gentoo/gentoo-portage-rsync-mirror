# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libcloud/libcloud-0.12.4-r1.ebuild,v 1.1 2013/07/06 15:31:49 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2} pypy2_0 )
PYTHON_REQ_USE="ssl"

inherit distutils-r1

DESCRIPTION="Unified Interface to the Cloud - python support libs"
HOMEPAGE="http://libcloud.apache.org/index.html"
SRC_URI="mirror://apache/${PN}/apache-${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND=""
DEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}]
	dev-python/lockfile[${PYTHON_USEDEP}] )"

DISTUTILS_IN_SOURCE_BUILD=1

S="${WORKDIR}/apache-${P}"

python_prepare_all() {
	if use examples; then
		mkdir examples
		mv example_*.py examples || die
	fi
	distutils-r1_python_prepare_all
}

python_test() {
	pushd "${BUILD_DIR}"/../ > /dev/null
	cp libcloud/test/secrets.py-dist libcloud/test/secrets.py || die
	esetup.py test
	popd > /dev/null
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
