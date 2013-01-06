# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/mitmproxy/mitmproxy-0.8.ebuild,v 1.1 2012/04/09 21:55:08 radhermit Exp $

EAPI="4"

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="libmproxy"

inherit distutils

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="http://mitmproxy.org/ http://pypi.python.org/pypi/mitmproxy/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/imaging-1.1
	>=dev-python/lxml-2.3
	>=dev-python/pyasn1-0.1.2
	>=dev-python/pyopenssl-0.12
	>=dev-python/urwid-1.0.0"
DEPEND="${RDEPEND}
	test? ( dev-python/pry )"

src_test() {
	cd test

	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" "${EROOT}"/usr/bin/pry
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	use doc && dohtml -r doc/*
	use examples && dodoc -r examples
}
