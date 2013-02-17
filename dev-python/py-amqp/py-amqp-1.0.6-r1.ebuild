# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-amqp/py-amqp-1.0.6-r1.ebuild,v 1.1 2013/02/17 12:55:30 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

MY_PN="amqp"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Low-level AMQP client for Python (fork of amqplib)"
HOMEPAGE="https://github.com/celery/py-amqp http://pypi.python.org/pypi/amqp/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples extras"

RDEPEND=""
DEPEND="${RDEPEND}"

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}/${P}_disable_socket_tests.patch"
	)

	distutils-r1_python_prepare_all
}

python_test() {
	cp -r -l funtests "${BUILD_DIR}"/ || die

	cd "${BUILD_DIR}" || die
	if [[ ${EPYTHON} == python3.* ]]; then
		# Notes:
		#   -W is not supported by python3.1
		#   -n causes Python to write into hardlinked files
		2to3 --no-diffs -w funtests || die
	fi

	"${PYTHON}" funtests/run_all.py || ewarn "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all

	dodoc -r docs/.
	if use examples; then
		docinto examples
		dodoc -r demo/.
		docompress -x /usr/share/doc/${PF}/examples
	fi
	if use extras; then
		insinto /usr/share/${PF}
		doins -r extra
	fi
}
