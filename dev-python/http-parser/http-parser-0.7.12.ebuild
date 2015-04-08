# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/http-parser/http-parser-0.7.12.ebuild,v 1.6 2014/03/31 21:13:13 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2} pypy pypy2_0 )

inherit distutils-r1 flag-o-matic

DESCRIPTION="HTTP request/response parser for python in C"
HOMEPAGE="http://github.com/benoitc/http-parser"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/cython"

PATCHES=( "${FILESDIR}/${PN}-0.7.8-setup.patch" )

python_compile() {
	if [[ ${EPYTHON} != python3* ]]; then
		local CFLAGS=${CFLAGS}
		append-cflags -fno-strict-aliasing
	fi
	distutils-r1_python_compile
}

python_install_all() {
	if use examples; then
		docompress -x usr/share/doc/${P}/examples
		insinto usr/share/doc/${P}
		doins -r examples/
	fi
}
