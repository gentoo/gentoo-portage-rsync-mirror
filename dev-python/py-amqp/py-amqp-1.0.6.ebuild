# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-amqp/py-amqp-1.0.6.ebuild,v 1.2 2013/01/08 21:58:40 iksaif Exp $

EAPI="5"

PYTHON_TESTS_RESTRICTED_ABIS="3.*"
PYTHON_DEPEND="2 3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_PN="amqp"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Low-level AMQP client for Python (fork of amqplib)"
HOMEPAGE="https://github.com/celery/py-amqp http://pypi.python.org/pypi/amqp/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples extras test"

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	if use test; then
		epatch "${FILESDIR}/${P}_disable_socket_tests.patch"
	fi
}

src_test() {

	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" python \
			"funtests/run_all.py"
	}

	python_execute_function testing
}

src_install() {
	distutils_src_install

	dodoc -r docs/*
	if use examples; then
		docinto examples
		dodoc demo/* || die "dodoc failed"
	fi
	if use extras; then
		insinto /usr/share/${PF}
		doins -r extra || die "doins failed"
	fi
}
