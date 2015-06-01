# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib

DESCRIPTION="Minimalistic C client library for the Redis database"
HOMEPAGE="http://github.com/redis/hiredis"
SRC_URI="http://github.com/redis/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x64-solaris"
IUSE="examples static-libs test"

DEPEND="test? ( dev-db/redis )"

src_prepare() {
	epatch "${FILESDIR}/${P}-disable-network-tests.patch"

	# use GNU ld syntax on Solaris
	sed -i -e '/DYLIB_MAKE_CMD=.* -G/d' Makefile || die
}

_emake() {
	emake \
		AR="$(tc-getAR)" \
		CC="$(tc-getCC)" \
		ARCH= \
		DEBUG= \
		OPTIMIZATION="${CPPFLAGS}" \
		"$@"
}

src_compile() {
	# The static lib re-uses the same objects as the shared lib, so
	# overhead is low w/creating it all the time.  It's also needed
	# by the tests.
	_emake dynamic static hiredis.pc
}

src_test() {
	local REDIS_PID="${T}"/hiredis.pid
	local REDIS_SOCK="${T}"/hiredis.sock
	local REDIS_PORT=56379
	local REDIS_TEST_CONFIG="daemonize yes \n
		pidfile ${REDIS_PID} \n
		port ${REDIS_PORT} \n
		bind 127.0.0.1 \n
		unixsocket //${REDIS_SOCK}"

	_emake hiredis-test

	echo -e ${REDIS_TEST_CONFIG} | /usr/sbin/redis-server - || die
	./hiredis-test -h 127.0.0.1 -p ${REDIS_PID} -s ${REDIS_SOCK} || die
	local ret=$?

	kill "$(<"${REDIS_PID}")" || die
	return ${ret}
}

src_install() {
	_emake PREFIX="${ED}/usr" LIBRARY_PATH="$(get_libdir)" install
	use static-libs || rm "${ED}/usr/$(get_libdir)/libhiredis.a"
	use examples && dohtml -r examples

	insinto /usr/$(get_libdir)/pkgconfig
	doins ${PN}.pc

	dodoc CHANGELOG.md README.md
}
