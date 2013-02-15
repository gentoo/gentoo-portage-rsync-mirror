# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyquery/pyquery-1.2.1-r1.ebuild,v 1.1 2013/02/15 19:20:18 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="A jQuery-like library for python"
HOMEPAGE="http://pypi.python.org/pypi/pyquery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND=">=dev-python/lxml-2.1[${PYTHON_USEDEP}]
	dev-python/cssselect[${PYTHON_USEDEP}]
	>=dev-python/webob-1.2_rc1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

DOCS=( CHANGES.txt README.txt )

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
