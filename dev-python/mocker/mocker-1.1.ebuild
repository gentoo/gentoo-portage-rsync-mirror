# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mocker/mocker-1.1.ebuild,v 1.1 2011/09/16 08:01:07 djc Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Platform for Python test doubles: mocks, stubs, fakes, and dummies"
HOMEPAGE="http://labix.org/mocker http://pypi.python.org/pypi/mocker"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

PYTHON_MODNAME="mocker.py"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test.py
	}
	python_execute_function testing
}
