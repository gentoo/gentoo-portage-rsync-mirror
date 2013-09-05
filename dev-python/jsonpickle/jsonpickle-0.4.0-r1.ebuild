# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jsonpickle/jsonpickle-0.4.0-r1.ebuild,v 1.4 2013/09/05 18:46:43 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Python library for serializing any arbitrary object graph into JSON"
HOMEPAGE="http://jsonpickle.github.com/ http://pypi.python.org/pypi/jsonpickle"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="dev-python/simplejson[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/feedparser[${PYTHON_USEDEP}] )"

python_test() {
	${PYTHON} tests/runtests.py || die
}
