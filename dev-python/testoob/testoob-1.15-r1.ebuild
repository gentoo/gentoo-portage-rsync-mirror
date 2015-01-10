# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testoob/testoob-1.15-r1.ebuild,v 1.1 2015/01/10 00:43:01 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Advanced Python testing framework"
HOMEPAGE="http://testoob.sourceforge.net/ http://pypi.python.org/pypi/testoob"
SRC_URI="mirror://sourceforge/testoob/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="pdf threads"

DEPEND=""
RDEPEND="pdf? ( dev-python/reportlab[${PYTHON_USEDEP}] )
	threads? ( dev-python/twisted-core[${PYTHON_USEDEP}] )"

DOCS="docs/*"

src_test() {
	testing() {
		PATH="build-${PYTHON_ABI}/scripts-${PYTHON_ABI}:${PATH}" PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" tests/alltests.py
	}
	python_execute_function testing
}
