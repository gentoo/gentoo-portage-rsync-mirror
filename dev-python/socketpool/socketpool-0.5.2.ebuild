# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/socketpool/socketpool-0.5.2.ebuild,v 1.4 2013/04/25 18:20:01 pinkbyte Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="A simple Python socket pool"
HOMEPAGE="http://github.com/benoitc/socketpool/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="examples"
LICENSE="|| ( MIT public-domain )"
SLOT="0"

RDEPEND="dev-python/gevent"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install
	if use examples; then
		docompress -x usr/share/doc/${P}/examples
		insinto usr/share/doc/${P}
		doins -r examples/
	fi
}
src_test() {
	PYTHONPATH=. py.test tests/test_pool_01.py
}
