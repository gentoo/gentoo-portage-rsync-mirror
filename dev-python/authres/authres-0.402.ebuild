# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/authres/authres-0.402.ebuild,v 1.1 2012/06/28 06:05:53 patrick Exp $

EAPI=4
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5"

inherit distutils

DESCRIPTION="Authentication Results Header Module"
HOMEPAGE="https://launchpad.net/authentication-results-python http://pypi.python.org/pypi/authres"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DOCS="CHANGES README"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)"  "$(PYTHON)" \
			-c "import sys, ${PN}, doctest; f, t = doctest.testfile('${PN}/tests'); \
				sys.exit(bool(f))" || return
	}
	python_execute_function testing
}
