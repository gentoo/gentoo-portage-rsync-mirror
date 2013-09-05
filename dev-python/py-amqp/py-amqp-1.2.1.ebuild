# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-amqp/py-amqp-1.2.1.ebuild,v 1.2 2013/09/05 18:46:01 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

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
IUSE="doc examples extras test"

RDEPEND=""
DEPEND="${RDEPEND}"

RESTRICT="test" # don't work, and fail quietly

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	cp -r -l funtests "${BUILD_DIR}"/lib/ || die
	cd "${BUILD_DIR}"/lib || die
	if [[ ${EPYTHON:6:1} == 3 ]]; then
		# Notes:
		#   -W is not supported by python3.1
		#   -n causes Python to write into hardlinked files
		2to3 --no-diffs -w funtests || die
	fi
	"${PYTHON}" funtests/run_all.py || ewarn "Tests fail with ${EPYTHON}"
	rm -rf funtests/ || die
}

python_install_all() {
	use examples && local EXAMPLES=( demo/. )
	use doc && local HTML_DOCS=( docs/.build/html/. )
	if use extras; then
		insinto /usr/share/${PF}/extras
		doins -r extra
	fi
	distutils-r1_python_install_all
}
