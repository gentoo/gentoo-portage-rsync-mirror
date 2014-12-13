# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apipkg/apipkg-1.2-r1.ebuild,v 1.4 2014/12/13 07:13:13 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="namespace control and lazy-import mechanism"
HOMEPAGE="http://pypi.python.org/pypi/apipkg"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	# https://bitbucket.org/hpk42/apipkg/issue/5/test-failure-with-python-34
	# Bug 530388. The test requires patching to match py3.4; trivial.
	py.test || die "Tests fail under ${EPYTHON}"
}
