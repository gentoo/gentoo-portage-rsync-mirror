# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/warlock/warlock-0.7.0.ebuild,v 1.1 2013/01/17 17:25:38 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="Python object model built on JSON schema and JSON patch"
HOMEPAGE="http://github.com/bcwaldon/warlock"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( virtual/python-unittest2[${PYTHON_USEDEP}]
				dev-python/jsonpatch
				dev-python/jsonschema )"
RDEPEND="dev-python/jsonpatch
		dev-python/jsonschema"

python_test() {
	"${PYTHON}" test/test_core.py || die
}
