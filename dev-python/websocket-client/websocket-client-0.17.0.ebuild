# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/websocket-client/websocket-client-0.17.0.ebuild,v 1.1 2014/08/31 01:02:48 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 )

inherit distutils-r1

DESCRIPTION="WebSocket client for python. hybi13 is supported"
HOMEPAGE="https://github.com/liris/websocket-client"

MY_P="${P/_alpha/a}"
SRC_URI="https://github.com/liris/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

DEPEND=""
RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/backports-ssl-match-hostname[${PYTHON_USEDEP}]' 'python2*' )
"

python_prepare_all() {
	ebegin 'patching setup.py'
	sed \
		-e '39s/"tests", //' \
		-i setup.py || die 'sed'
	eend $?

	distutils-r1_python_prepare_all
}

python_test() {
	python tests/test_websocket.py || die 'test_websocket'
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
