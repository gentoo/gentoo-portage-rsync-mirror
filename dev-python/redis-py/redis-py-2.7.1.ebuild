# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/redis-py/redis-py-2.7.1.ebuild,v 1.4 2012/12/31 22:45:41 ago Exp $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="redis"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python client for Redis key-value store"
HOMEPAGE="http://github.com/andymccurdy/redis-py http://pypi.python.org/pypi/redis"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

DEPEND="dev-python/setuptools
	test? ( dev-db/redis )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="README.md CHANGES"
PYTHON_MODNAME="redis"

src_test() {
	local sock="${T}/redis.sock"
	find tests/ -name "*.py" -not -name "encoding.py" -exec sed -i -e "s:port=6379:unix_socket_path=\"${sock}\":" {} \;

	"${EPREFIX}"/usr/sbin/redis-server - \
	<<< "daemonize yes
		pidfile ${T}/redis.pid
		unixsocket ${sock}"
	distutils_src_test
	kill "$(<"${T}/redis.pid")"
}
