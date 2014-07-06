# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/warlock/warlock-0.7.0.ebuild,v 1.4 2014/07/06 12:50:33 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python object model built on JSON schema and JSON patch"
HOMEPAGE="http://github.com/bcwaldon/warlock"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( =dev-python/jsonpatch-0.10[${PYTHON_USEDEP}]
				dev-python/jsonschema[${PYTHON_USEDEP}] )"
RDEPEND="=dev-python/jsonpatch-0.10[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" test/test_core.py || die
}
