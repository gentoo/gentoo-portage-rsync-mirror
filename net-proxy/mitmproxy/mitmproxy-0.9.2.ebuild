# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/mitmproxy/mitmproxy-0.9.2.ebuild,v 1.1 2014/01/30 05:56:25 radhermit Exp $

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

RDEPEND="virtual/python-imaging[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
	>=dev-python/netlib-${PV}[${PYTHON_USEDEP}]
	>dev-python/pyasn1-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.12[${PYTHON_USEDEP}]
	>=dev-python/urwid-1.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		www-servers/pathod[${PYTHON_USEDEP}]
	)"

RESTRICT="test"

PATCHES=( "${FILESDIR}"/${PN}-0.9.1-pil-import.patch )

python_test() {
	nosetests -v || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( CHANGELOG CONTRIBUTORS )
	use doc && local HTML_DOCS=( doc/. )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
