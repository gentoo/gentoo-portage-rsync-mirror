# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/selenium/selenium-2.26.0.ebuild,v 1.1 2012/11/29 14:25:51 idella4 Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
#RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy-*"
inherit distutils

DESCRIPTION="a Python language binding for Selenium Remote Control (version 1.0 and 2.0)"
HOMEPAGE="http://pypi.python.org/pypi/selenium/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="doc"
LICENSE="Apache-2.0"
SLOT="0"
DOCS=( README.md py/README )

src_install() {
	distutils_src_install
	dodoc ${DOCS[@]}
}
