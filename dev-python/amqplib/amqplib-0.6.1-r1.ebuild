# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/amqplib/amqplib-0.6.1-r1.ebuild,v 1.1 2013/05/16 01:03:03 prometheanfire Exp $

EAPI="5"
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="Python client for the Advanced Message Queuing Procotol (AMQP)"
HOMEPAGE="http://code.google.com/p/py-amqplib/"
SRC_URI="http://py-amqplib.googlecode.com/files/${P}.tgz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples extras test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

python_prepare_all() {
	if use test; then
		epatch "${FILESDIR}/${P}_disable_socket_tests.patch"
	fi
	distutils-r1_python_prepare_all
}

python_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" python \
			"tests/client_0_8/run_all.py"
	}
	python_execute_function testing
}

python_install_all() {
	distutils-r1_python_install_all

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
