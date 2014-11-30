# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ptrace/python-ptrace-0.8.ebuild,v 1.2 2014/11/30 16:55:05 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="python-ptrace is a debugger using ptrace (Linux, BSD and Darwin system call to trace processes)"
HOMEPAGE="http://bitbucket.org/haypo/python-ptrace/ http://pypi.python.org/pypi/python-ptrace"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND=""
RDEPEND="dev-libs/distorm64[${PYTHON_USEDEP}]"
# Req'd for tests
DISTUTILS_IN_SOURCE_BUILD=1

python_test() {
	"${PYTHON}" test_doc.py || die "tests failed under ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	# doc folder missing key files to effect a proper doc build
	use doc && local DOCS=( README doc/* )
	distutils-r1_python_install_all
}
