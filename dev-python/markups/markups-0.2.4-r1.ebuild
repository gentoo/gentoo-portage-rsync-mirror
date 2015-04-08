# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/markups/markups-0.2.4-r1.ebuild,v 1.4 2014/12/28 12:12:30 ago Exp $

EAPI="5"

PYTHON_COMPAT=( python2_7 python{3_3,3_4} pypy )

DISTUTILS_NO_PARALLEL_BUILD="true"

inherit distutils-r1

MY_PN="Markups"
MY_P=${MY_PN}-${PV}

DESCRIPTION="A wrapper around various text markups"
HOMEPAGE="http://pypi.python.org/pypi/Markups"
SRC_URI="mirror://pypi/M/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

S="${WORKDIR}"/${MY_P}

DEPEND="dev-python/markdown[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_test() {
	pushd tests > /dev/null
		for test in test_*.py ; do
			local testName="$(echo ${test} | sed 's/test_\(.*\).py/\1/g')"
			einfo "Running test '${testName}' with '${EPYTHON}'."
			${EPYTHON} ${test} || die "Test '${testName}' with '${EPYTHON}' failed."
		done
	popd tests > /dev/null
}
