# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jsonschema/jsonschema-2.3.0.ebuild,v 1.7 2015/02/20 10:09:53 pacho Exp $

EAPI=5
PYTHON_COMPAT=(python{2_6,2_7,3_{2,3,4}} pypy pypy2_0)
inherit distutils-r1

DESCRIPTION="An implementation of JSON-Schema validation for Python"
HOMEPAGE="http://pypi.python.org/pypi/jsonschema"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="test"

python_test() {
	local runner=( "${PYTHON}" -m unittest )
	if [[ ${EPYTHON} == python2.6 || ${EPYTHON} == python3.1 ]]; then
		unset PYTHONPATH
		runner=( unit2.py )
	fi
	"${runner[@]}" discover || die "Testing failed with ${EPYTHON}"
}
