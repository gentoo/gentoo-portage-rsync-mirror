# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/mitmproxy/mitmproxy-0.8.1.ebuild,v 1.2 2013/05/11 11:22:48 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="http://mitmproxy.org/ http://pypi.python.org/pypi/mitmproxy/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/imaging-1.1[${PYTHON_USEDEP}]
	>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.12[${PYTHON_USEDEP}]
	>=dev-python/urwid-1.0.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/pry[${PYTHON_USEDEP}] )"

python_test() {
	cd test || die
	pry || die
}

python_install_all() {
	use doc && dohtml -r doc/*
	use examples && dodoc -r examples
}
