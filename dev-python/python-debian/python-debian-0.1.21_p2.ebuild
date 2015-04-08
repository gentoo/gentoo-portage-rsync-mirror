# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-debian/python-debian-0.1.21_p2.ebuild,v 1.5 2015/04/08 08:05:07 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Python modules to work with Debian-related data formats"
HOMEPAGE="http://packages.debian.org/sid/python-debian"
MY_PV="${PV/_p/+nmu}"
SRC_URI="mirror://debian/pool/main/${P:0:1}/${PN}/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( app-arch/dpkg )"

S="${WORKDIR}/${PN}-${MY_PV}"
DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all() {
	sed -e "s/__CHANGELOG_VERSION__/${MY_PV}/" setup.py.in > setup.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	"${PYTHON}" lib/debian/doc-debtags > README.debtags || die
}

python_test() {
	pushd tests > /dev/null || die
	local t
	for t in test_*.py ; do
		"${PYTHON}" "${t}" || die "Testing failed with ${EPYTHON}"
	done
	popd > /dev/null || die
}

python_install_all() {
	use examples && local EXAMPLES=( examples/ )
	distutils-r1_python_install_all
}
