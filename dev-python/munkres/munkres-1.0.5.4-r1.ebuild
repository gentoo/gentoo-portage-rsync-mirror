# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/munkres/munkres-1.0.5.4-r1.ebuild,v 1.1 2012/05/30 12:44:32 xarthisius Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Module implementing munkres algorithm for the Assignment Problem"
HOMEPAGE="http://pypi.python.org/pypi/munkres/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_test() {
	testing() {
		"$(PYTHON)" ${PN}.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dohtml -r html/
}
