# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyro/pyro-4.8.ebuild,v 1.5 2012/02/27 15:25:40 ranger Exp $

EAPI="3"
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45]"

inherit distutils

MY_PN="Pyro4"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Advanced and powerful Distributed Object Technology system written entirely in Python"
HOMEPAGE="http://www.xs4all.nl/~irmen/pyro/ http://pypi.python.org/pypi/Pyro4"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="4"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND="!dev-python/pyro:0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? (
		dev-python/coverage
		dev-python/nose
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="Pyro4"

src_prepare() {
	distutils_src_prepare

	sed -e '/sys.path.insert/a sys.path.insert(1,"PyroTests")' -i tests/run_suite.py

	# Disable tests requiring network connection.
	sed \
		-e "s/testBCstart/_&/" \
		-e "s/testDaemonPyroObj/_&/" \
		-e "s/testLookupAndRegister/_&/" \
		-e "s/testMulti/_&/" \
		-e "s/testRefuseDottedNames/_&/" \
		-e "s/testResolve/_&/" \
		-i tests/PyroTests/test_naming.py
	sed \
		-e "s/testOwnloopBasics/_&/" \
		-e "s/testStartNSfunc/_&/" \
		-i tests/PyroTests/test_naming2.py

	sed \
		-e "s/testServerConnections/_&/" \
	    -e "s/testServerParallelism/_&/" \
		-i tests/PyroTests/test_server.py

	sed \
		-e "s/testBroadcast/_&/" \
		-e "s/testGetIP/_&/" \
		-i tests/PyroTests/test_socket.py
}

src_test() {
	cd tests

	testing() {
		"$(PYTHON)" run_suite.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Installation of examples failed"
	fi
}
