# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytools/pytools-2013.2.ebuild,v 1.2 2013/09/05 18:46:05 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A collection of tools missing from the Python standard library"
HOMEPAGE="http://mathema.tician.de/software/pytools"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND=""

python_test() {
	py.test || die "Tests fail with ${EPYTHON}"
}
