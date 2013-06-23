# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hgtools/hgtools-3.0.2.ebuild,v 1.1 2013/06/23 12:11:50 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1 eutils

DESCRIPTION="Classes and setuptools plugin for Mercurial repositories"
HOMEPAGE="https://bitbucket.org/jaraco/hgtools/"
SRC_URI="mirror://pypi/h/${PN}/${P}.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"

DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND="dev-vcs/mercurial"
DISTUTILS_IN_SOURCE_BUILD=1

python_test() {
	# new py3 test failures https://bitbucket.org/jaraco/hgtools/issue/14/test_reentrypy-py3-5-failures-from-8-tests
	pushd "${BUILD_DIR}"/../ > /dev/null
	py.test "${PN}"/tests || die
}
