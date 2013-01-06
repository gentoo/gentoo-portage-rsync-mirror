# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/markdown2/markdown2-2.1.0.ebuild,v 1.1 2012/10/05 12:19:48 djc Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python Markdown language reimplementation"
SRC_URI="mirror://pypi/m/markdown2/${P}.zip"
HOMEPAGE="http://github.com/trentm/python-markdown2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
PYTHON_MODNAME="markdown2.py"

DEPEND="dev-python/pygments"
RDEPEND="${DEPEND}"

src_prepare() {
	rm -f test/tm-cases/issue52* || die
}

src_test() {
	cd test || die
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test.py
	}
	python_execute_function testing
}
