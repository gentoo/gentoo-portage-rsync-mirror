# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ptrace/python-ptrace-0.8.1.ebuild,v 1.4 2014/12/01 02:16:04 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="python-ptrace is a debugger using ptrace (Linux, BSD and Darwin system call to trace processes)"
HOMEPAGE="http://bitbucket.org/haypo/python-ptrace/ http://pypi.python.org/pypi/python-ptrace"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

python_test() {
	# Python 3.4 adds SOCK_CLOEXEC to socket.type automatically, and ptrace does
	# not translate that on output causing it to fail test_strace.test_socket.
	# https://bitbucket.org/haypo/python-ptrace/issue/17
	"${PYTHON}" runtests.py || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	# doc folder missing key files to effect a proper doc build
	use doc && local DOCS=( README doc/* )
	distutils-r1_python_install_all
}
