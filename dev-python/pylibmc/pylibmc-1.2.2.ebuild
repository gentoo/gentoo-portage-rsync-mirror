# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylibmc/pylibmc-1.2.2.ebuild,v 1.1 2011/10/30 13:55:36 djc Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Libmemcached wrapper written as a Python extension"
HOMEPAGE="http://sendapatch.se/projects/pylibmc/ http://pypi.python.org/pypi/pylibmc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/libmemcached-0.32"
DEPEND="${RDEPEND}"

src_prepare() {
	distutils_src_prepare
	sed -e "/with-info=1/d" -i setup.cfg
}

src_test() {
	memcached -d -p 11219 -l localhost -P "${T}/memcached.pid"
	MEMCACHED_PORT=11219 distutils_src_test
	kill "$(<"${T}/memcached.pid")"
}
