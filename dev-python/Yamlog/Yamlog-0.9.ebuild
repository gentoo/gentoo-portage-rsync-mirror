# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Yamlog/Yamlog-0.9.ebuild,v 1.2 2013/12/15 04:10:23 idella4 Exp $
# the test phase goes seeking Yamlog, not yamlog; semantics. Yamlog for now

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Logging in YAML format"
# Seems kless has done a runner. Someone please find a home page, putting in pypi for now
HOMEPAGE="http://github.com/kless/Yamlog/ https://pypi.python.org/pypi/Yamlog/0.9"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="test"
LICENSE="ISC"
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}] )"

RDEPEND=""

python_test() {
	esetup.py test
}
