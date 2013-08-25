# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libasyncns-python/libasyncns-python-0.7.1-r1.ebuild,v 1.1 2013/08/25 17:21:09 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Python bindings for libasyncns."
HOMEPAGE="https://launchpad.net/libasyncns-python/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-libs/libasyncns-0.4"
RDEPEND="${DEPEND}"

python_compile() {
	if [[ ${EPYTHON} != python3* ]]; then
		local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
	fi
	distutils-r1_python_compile
}

# Tests are network-dependent
