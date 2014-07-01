# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/docker-py/docker-py-0.3.2.ebuild,v 1.1 2014/07/01 21:40:15 chutzpah Exp $

EAPI=5
PYTHON_COMPAT=(python3_{3,4})
inherit distutils-r1

DESCRIPTION="An API client for docker."
HOMEPAGE="https://github.com/dotcloud/docker-py"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/mock-1.0.1[${PYTHON_USEDEP}] )"
RDEPEND=">=dev-python/requests-2.2.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}"/${P}-no-version-lock.patch
)

# upstream archive does not include the tests
RESTRICT=test

python_test() {
	PYTHONPATH="${S}" esetup.py test || die
}
