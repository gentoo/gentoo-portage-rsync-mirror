# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eventlet/eventlet-0.9.16.ebuild,v 1.3 2013/02/01 02:34:27 idella4 Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Highly concurrent networking library"
HOMEPAGE="http://pypi.python.org/pypi/eventlet"
SRC_URI="mirror://pypi/e/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

DEPEND="doc? ( dev-python/sphinx )
	test? ( dev-python/greenlet
		net-libs/gnutls
		dev-python/httplib2 )"
RDEPEND="dev-python/greenlet"

src_compile() {
	distutils_src_compile

	if use doc ; then
		emake -C doc html || die
	fi
}

src_prepare() {
	sed -e 's:import time:import time, traceback:' -i tests/mysqldb_test.py || die
	distutils_src_prepare
}

src_install() {
	distutils_src_install

	use doc && dohtml -r doc/_build/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}
