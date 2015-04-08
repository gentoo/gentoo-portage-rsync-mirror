# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/redis-py/redis-py-2.10.1.ebuild,v 1.3 2014/10/14 12:06:19 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

MY_PN="redis"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python client for Redis key-value store"
HOMEPAGE="http://github.com/andymccurdy/redis-py"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-db/redis
		>=dev-python/pytest-2.5.0[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# Disable pubsub and encoding tests, they do not seem to support
	# UNIX socket connectivity.
	sed -i -e '/PubSub/d' -e '/Encoding/d' \
		-e '/use_hiredis:/d' tests/__init__.py || die

	# Make sure that tests will be used from BUILD_DIR rather than cwd.
	mv tests tests-hidden || die

	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile

	if use test; then
		cp -r tests-hidden "${BUILD_DIR}"/tests || die
	fi
}

src_test() {
	local DISTUTILS_NO_PARALLEL_BUILD=1

	distutils-r1_src_test
}

python_test() {
	# https://github.com/andymccurdy/redis-py/issues/503
	# the suite is quite broken at this point but it's also the case in -2.9.1,
	# making this not a regression. but a fix is in 'progress', just not the overlay one
	local pidfile=${T}/redis-${EPYTHON}.pid
	local sock=${T}/redis-${EPYTHON}.sock

	sed -i -e "s:port=6379:unix_socket_path=\"${sock}\":" \
		"${BUILD_DIR}"/tests/*.py || die

	# XXX: find a way to make sure it is killed

	"${EPREFIX}"/usr/sbin/redis-server \
		--pidfile "${pidfile}" \
		--port 0 \
		--unixsocket "${sock}" \
		--daemonize yes || die
	PYTHONPATH="${PYTHONPATH}:${BUILD_DIR}" \
		esetup.py test
	kill "$(<"${pidfile}")"
}
