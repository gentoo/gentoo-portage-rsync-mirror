# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/turbojson/turbojson-1.3-r1.ebuild,v 1.2 2013/05/10 05:16:01 patrick Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

MY_PN="TurboJson"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="TurboGears JSON file format support plugin"
HOMEPAGE="http://pypi.python.org/pypi/TurboJson"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=">=dev-python/decoratortools-1.4[${PYTHON_USEDEP}]
	>=dev-python/ruledispatch-0.5_pre2306[$(python_gen_usedep 'python2*')]
	>=dev-python/simplejson-2.6.2[${PYTHON_USEDEP}]
	>=dev-python/peak-rules-0.5[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[$(python_gen_usedep python{2_6,2_7})]
		dev-python/sqlobject
		>=dev-python/peak-rules-0.5[${PYTHON_USEDEP}]
		)"

S="${WORKDIR}/${MY_P}"

python_test() {
	cd "${BUILD_DIR}/lib/${PN}/tests/" || die
	for test in test_*.py; do
		"${PYTHON}" $test && einfo "Test $test passed under ${EPYTHON}" \
		|| die "tests failed under ${EPYTHON}"
	done
}
