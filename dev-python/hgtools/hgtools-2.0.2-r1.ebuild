# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hgtools/hgtools-2.0.2-r1.ebuild,v 1.4 2015/04/08 08:05:08 mgorny Exp $

EAPI=5
# python3.2+: bug #450666 (doctest failure)
PYTHON_COMPAT=( python{2_7,3_3} pypy )

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

src_prepare() {
	epatch "${FILESDIR}/hgtools-doctest-2.0.2.patch"
}

python_test() {
	py.test "${BUILD_DIR}"/lib test || die
}
