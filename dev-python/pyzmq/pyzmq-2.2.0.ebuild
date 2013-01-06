# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyzmq/pyzmq-2.2.0.ebuild,v 1.3 2012/08/29 17:00:38 floppym Exp $

EAPI="3"
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 *-jython 2.7-pypy-*"
DISTUTILS_SRC_TEST="nosetests"
PYTHON_TESTS_RESTRICTED_ABIS="3*"

inherit distutils eutils

DESCRIPTION="PyZMQ is a lightweight and super-fast messaging library built on top of the ZeroMQ library"
HOMEPAGE="http://www.zeromq.org/bindings:python http://pypi.python.org/pypi/pyzmq"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples test"

RDEPEND=">=net-libs/zeromq-2.1.9"
DEPEND="${RDEPEND}
	test? ( www-servers/tornado )"

DOCS="README.rst"
PYTHON_MODNAME="zmq"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" nosetests -sv $(ls -d build-${PYTHON_ABI}/lib.*)
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
