# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/envoy/envoy-0.0.2.ebuild,v 1.3 2012/01/15 19:14:25 tove Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit distutils

DESCRIPTION="Simple API for running external processes"
HOMEPAGE="https://github.com/kennethreitz/envoy http://pypi.python.org/pypi/envoy"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

# Upstream forgot test_envoy.py in manifest. https://github.com/kennethreitz/envoy/pull/11
RESTRICT="test"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test_envoy.py
	}
	python_execute_function testing
}
