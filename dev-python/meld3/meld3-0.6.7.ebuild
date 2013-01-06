# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/meld3/meld3-0.6.7.ebuild,v 1.2 2012/09/29 22:06:01 radhermit Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="meld3 is an HTML/XML templating engine."
HOMEPAGE="https://github.com/supervisor/meld3 http://pypi.python.org/pypi/meld3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="CHANGES.txt COPYRIGHT.txt LICENSE.txt README.txt TODO.txt"

src_test() {
	cd meld3
	testing() {
		"$(PYTHON)" test_meld3.py
	}
	python_execute_function testing
}
