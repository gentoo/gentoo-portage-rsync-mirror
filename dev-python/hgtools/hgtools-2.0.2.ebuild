# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hgtools/hgtools-2.0.2.ebuild,v 1.5 2013/01/06 23:07:24 mgorny Exp $

EAPI=5
# python3.2+: bug #450666 (doctest failure)
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1

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

python_test() {
	py.test "${BUILD_DIR}"/lib test || die
}
