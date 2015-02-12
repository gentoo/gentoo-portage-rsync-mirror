# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyzmq/pyzmq-2.2.0.1-r1.ebuild,v 1.7 2015/02/12 02:32:56 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="PyZMQ is a lightweight and super-fast messaging library built on top of the ZeroMQ library"
HOMEPAGE="http://www.zeromq.org/bindings:python http://pypi.python.org/pypi/pyzmq"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="examples test"

PY2_USEDEP=$(python_gen_usedep 'python2*')

RDEPEND=">=net-libs/zeromq-2.1.9"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PY2_USEDEP}]
		dev-python/gevent[${PY2_USEDEP}]
		www-servers/tornado[${PY2_USEDEP}] )"

PATCHES=(
	"${FILESDIR}/${PN}-2.2.0.1-python3.patch"
)

# Configure checks write to cwd.
# https://github.com/zeromq/pyzmq/issues/318
DISTUTILS_IN_SOURCE_BUILD=1

python_test() {
	if [[ ${EPYTHON} == python3* ]]; then
		einfo "Skipping tests for ${EPYTHON}, not supported."
	else
		nosetests -svw build/lib* || die "Tests fail with ${EPYTHON}"
	fi
}

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
