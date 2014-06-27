# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/funcsigs/funcsigs-0.4.ebuild,v 1.2 2014/06/27 01:50:48 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

DESCRIPTION="Python function signatures from PEP362 for Python 2.7"
HOMEPAGE="https://pypi.python.org/pypi/funcsigs"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="test? ( dev-python/unittest2[${PYTHON_USEDEP}] )"

python_test() {
	esetup.py test
}
