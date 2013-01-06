# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/netaddr/netaddr-0.7.10.ebuild,v 1.3 2012/11/22 10:04:47 ago Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"

inherit distutils

DESCRIPTION="Network address representation and manipulation library"
HOMEPAGE="https://github.com/drkjam/netaddr http://pypi.python.org/pypi/netaddr"
SRC_URI="mirror://github/drkjam/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cli"

DEPEND=""
RDEPEND="cli? ( dev-python/ipython )"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" netaddr/tests/__init__.py
	}
	python_execute_function testing
}

pkg_postinst() {
	distutils_pkg_postinst
	if ! use cli; then
		ewarn "If you intend to use netaddr shell in terminal, enable cli USE flag"
	fi
}
