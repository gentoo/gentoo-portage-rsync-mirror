# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyRSS2Gen/PyRSS2Gen-1.0.0.ebuild,v 1.2 2011/09/14 08:01:58 djc Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="RSS feed generator written in Python"
HOMEPAGE="http://www.dalkescientific.com/Python/PyRSS2Gen.html http://pypi.python.org/pypi/PyRSS2Gen"
SRC_URI="http://www.dalkescientific.com/Python/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="${PN}.py"

src_install() {
	distutils_src_install

	if use examples; then
		dodoc example.py || die
	fi
}
