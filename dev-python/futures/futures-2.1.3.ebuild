# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/futures/futures-2.1.3.ebuild,v 1.1 2012/08/29 05:27:30 patrick Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="concurrent futures"

inherit distutils

DESCRIPTION="A backport of the concurrent.futures package from Python 3.2"
HOMEPAGE="http://code.google.com/p/pythonfutures/ http://pypi.python.org/pypi/futures"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"

DOCS=( CHANGES )

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test_futures.py
	}
	python_execute_function testing
}
