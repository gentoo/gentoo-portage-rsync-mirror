# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/speaklater/speaklater-1.3-r1.ebuild,v 1.2 2013/09/05 18:46:44 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )
inherit distutils-r1

DESCRIPTION="Lazy strings for Python"
HOMEPAGE="https://github.com/mitsuhiko/speaklater"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

DISTUTILS_IN_SOURCE_BUILD=1

python_test() {
	"${PYTHON}" speaklater.py || die "Tests failed under ${EPYTHON}"
}
