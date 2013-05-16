# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/mitmproxy/mitmproxy-0.9.ebuild,v 1.1 2013/05/16 08:40:52 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="http://mitmproxy.org/"
SRC_URI="http://mitmproxy.org/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/imaging-1.1[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
	>=dev-python/netlib-0.9[${PYTHON_USEDEP}]
	>dev-python/pyasn1-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.12[${PYTHON_USEDEP}]
	>=dev-python/urwid-1.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		www-servers/pathod[${PYTHON_USEDEP}]
	)"

RESTRICT="test"

python_test() {
	nosetests -v || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	dodoc CHANGELOG CONTRIBUTORS
	use doc && dohtml -r doc/*
	use examples && dodoc -r examples
}
