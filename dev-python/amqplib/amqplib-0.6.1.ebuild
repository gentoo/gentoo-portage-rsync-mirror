# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/amqplib/amqplib-0.6.1.ebuild,v 1.1 2011/07/06 21:38:06 neurogeek Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Python client for the Advanced Message Queuing Procotol (AMQP)"
HOMEPAGE="http://code.google.com/p/py-amqplib/"
SRC_URI="http://py-amqplib.googlecode.com/files/${P}.tgz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples extras test"

RDEPEND=""
DEPEND="${RDEPEND}"

RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	if use test; then
		epatch "${FILESDIR}/${P}_disable_socket_tests.patch"
	fi
}

src_test() {

	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" python \
			"tests/client_0_8/run_all.py"
	}

	python_execute_function testing
}

src_install() {
	distutils_src_install

	dodoc docs/*
	if use examples; then
		docinto examples
		dodoc demo/* || die "dodoc failed"
	fi
	if use extras; then
		insinto /usr/share/${PF}
		doins -r extras || die "doins failed"
	fi
}
