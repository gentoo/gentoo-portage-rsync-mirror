# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/markdown2/markdown2-1.3.1.ebuild,v 1.1 2012/04/19 08:28:21 patrick Exp $

EAPI=3

PYTHON_DEPEND="2:2.5"
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

DEPEND="dev-python/pygments"
RDEPEND="${DEPEND}"

src_test() {
	cd test || die
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test.py
	}
	python_execute_function testing
}
