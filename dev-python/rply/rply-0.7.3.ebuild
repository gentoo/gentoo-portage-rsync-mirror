# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rply/rply-0.7.3.ebuild,v 1.1 2014/12/29 11:56:51 djc Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Pure python parser generator that also works with RPython"
HOMEPAGE="https://github.com/alex/rply"
SRC_URI="https://github.com/alex/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/py[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare() {
	# https://github.com/alex/rply/issues/26; fail under py[3-4]
	if python_is_python3; then
		sed -e s':test_simple:_&:' -e s':test_empty_production:_&:' \
			-i tests/test_parsergenerator.py
	fi
	distutils-r1_python_prepare
}

python_test() {
	py.test || die "Tests fail with ${EPYTHON}"
}
