# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyftpdlib/pyftpdlib-1.3.0.ebuild,v 1.6 2015/03/21 08:35:32 jer Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3} pypy )
PYTHON_REQ_USE="ssl(+)"

inherit distutils-r1

DESCRIPTION="Python FTP server library"
HOMEPAGE="http://code.google.com/p/pyftpdlib/ http://pypi.python.org/pypi/pyftpdlib"
SRC_URI="http://pyftpdlib.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE="examples ssl"

DEPEND="ssl? ( dev-python/pyopenssl[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"

# Usual; requ'd for a sane testsuite run
DISTUTILS_NO_PARALLEL_BUILD=1

python_prepare_all() {
	# http://code.google.com/p/pyftpdlib/issues/detail?id=292&thanks=292&ts=1400308829
	# Disable failing test
	sed -e 's:test_on_incomplete_file_received:_&:' -i test/test_ftpd.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" test/test_ftpd.py || die
}

python_install_all() {
	use examples && local EXAMPLES=( demo/. )
	distutils-r1_python_install_all
}
