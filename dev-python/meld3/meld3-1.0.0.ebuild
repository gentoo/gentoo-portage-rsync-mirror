# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/meld3/meld3-1.0.0.ebuild,v 1.1 2014/05/12 15:48:32 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="meld3 is an HTML/XML templating engine."
HOMEPAGE="https://github.com/supervisor/meld3 http://pypi.python.org/pypi/meld3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# tests use a local path.
RESTRICT=test

python_test() {
	PYTHONPATH=. "${PYTHON}" ${PN}/test_${PN}.py || die "Tests failed under ${EPYTHON}"
}
