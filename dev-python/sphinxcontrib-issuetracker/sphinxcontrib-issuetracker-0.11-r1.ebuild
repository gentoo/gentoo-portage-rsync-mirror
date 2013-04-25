# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sphinxcontrib-issuetracker/sphinxcontrib-issuetracker-0.11-r1.ebuild,v 1.1 2013/04/25 11:12:08 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Extension to sphinx to create links to issue trackers"
HOMEPAGE="http://sphinxcontrib-issuetracker.readthedocs.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# There are docs but electing to leave them excluded; they d'load objects.inv not once but twice
IUSE="test"

RDEPEND=">=dev-python/requests-0.13[${PYTHON_USEDEP}]
	>=dev-python/sphinx-1.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pyquery[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_prepare() {
	# test requires network access (bug #425694)
	rm tests/test_builtin_trackers.py || die

	# Tests from tests/test_stylesheet.py require dev-python/PyQt4[X,webkit]
	# and virtualx.eclass.
	rm tests/test_stylesheet.py || die
}

python_test() {
	py.test || die
}
